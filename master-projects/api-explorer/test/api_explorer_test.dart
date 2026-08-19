import 'package:dfm_api_explorer/api_controller.dart';
import 'package:dfm_api_explorer/api_models.dart';
import 'package:dfm_api_explorer/api_transport.dart';
import 'package:dfm_api_explorer/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('demo transport normalizes paths and reports deterministic responses', () async {
    const transport = DemoApiTransport();
    final response = await transport.send(
      const ApiRequest(verb: HttpVerb.get, path: 'status'),
    );

    expect(response.statusCode, 200);
    expect(response.isSuccess, isTrue);
    expect(response.body, containsPair('path', '/status'));
  });

  test('controller tracks history and validation errors', () async {
    final controller = ApiController(transport: const DemoApiTransport());

    await controller.execute(const ApiRequest(verb: HttpVerb.get, path: '   '));
    expect(controller.error, isNotNull);
    expect(controller.history, isEmpty);

    await controller.execute(const ApiRequest(verb: HttpVerb.post, path: '/items'));
    expect(controller.latest?.statusCode, 201);
    expect(controller.history.single.request.verb, HttpVerb.post);

    controller.clearHistory();
    expect(controller.history, isEmpty);
    expect(controller.latest, isNull);
  });

  test('demo failure path produces inspectable HTTP failure', () async {
    final controller = ApiController(transport: const DemoApiTransport());
    await controller.execute(const ApiRequest(verb: HttpVerb.get, path: '/fail'));
    expect(controller.latest?.statusCode, 503);
    expect(controller.latest?.isSuccess, isFalse);
    expect(controller.error, isNull);
  });

  testWidgets('API Explorer sends a demo request and renders history', (tester) async {
    final controller = ApiController(transport: const DemoApiTransport());
    await tester.pumpWidget(ApiExplorerApp(controller: controller));

    await tester.tap(find.text('Send demo request'));
    await tester.pump();

    expect(find.textContaining('Status 200'), findsOneWidget);
    expect(find.text('History (1)'), findsOneWidget);
    expect(find.text('GET /status'), findsOneWidget);
  });
}
