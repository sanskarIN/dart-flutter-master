import 'package:dfm_part_017/networking.dart';
import 'package:dfm_part_017/part_017.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ArticleApi decodes typed article data and repository caches it', () async {
    Uri? requestedUri;
    final api = ArticleApi(
      baseUri: Uri.parse('https://example.invalid/api/'),
      transport: (uri) async {
        requestedUri = uri;
        return const RestResponse(
          statusCode: 200,
          body: '[{"id":1,"title":"  Architecture  "}]',
        );
      },
    );
    final repository = ArticleRepository(api);

    final articles = await repository.refresh();

    expect(requestedUri.toString(), 'https://example.invalid/articles');
    expect(articles.single.id, 1);
    expect(articles.single.title, 'Architecture');
    expect(repository.cachedArticles.single.title, 'Architecture');
  });

  test('ArticleApi exposes HTTP failures explicitly', () async {
    final api = ArticleApi(
      baseUri: Uri.parse('https://example.invalid'),
      transport: (_) async => const RestResponse(statusCode: 503, body: '{}'),
    );

    await expectLater(
      api.fetchArticles(),
      throwsA(
        isA<ApiFailure>()
            .having((error) => error.statusCode, 'statusCode', 503),
      ),
    );
  });

  test('ArticleApi rejects malformed payloads', () async {
    final api = ArticleApi(
      baseUri: Uri.parse('https://example.invalid'),
      transport: (_) async => const RestResponse(statusCode: 200, body: '{bad json'),
    );

    await expectLater(api.fetchArticles(), throwsA(isA<ApiFailure>()));
  });

  testWidgets('network screen renders successful article data', (tester) async {
    final repository = ArticleRepository(
      ArticleApi(
        baseUri: Uri.parse('https://example.invalid'),
        transport: (_) async => const RestResponse(
          statusCode: 200,
          body: '[{"id":7,"title":"Testable REST"}]',
        ),
      ),
    );

    await tester.pumpWidget(NetworkingMasteryApp(repository: repository));
    await tester.pumpAndSettle();

    expect(find.text('Testable REST'), findsOneWidget);
    expect(find.text('Article #7'), findsOneWidget);
  });

  testWidgets('network screen renders API failures', (tester) async {
    final repository = ArticleRepository(
      ArticleApi(
        baseUri: Uri.parse('https://example.invalid'),
        transport: (_) async => const RestResponse(statusCode: 500, body: '{}'),
      ),
    );

    await tester.pumpWidget(NetworkingMasteryApp(repository: repository));
    await tester.pumpAndSettle();

    expect(find.text('Request failed with HTTP 500.'), findsOneWidget);
  });
}
