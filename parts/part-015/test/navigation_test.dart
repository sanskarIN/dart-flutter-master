import 'package:dfm_part_015/app_route.dart';
import 'package:dfm_part_015/part_015.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppRoute.parse', () {
    test('parses home and parameterized item routes', () {
      expect(AppRoute.parse('/').isHome, isTrue);
      expect(AppRoute.parse('/items/42').itemId, 42);
      expect(AppRoute.parse('/items/42').location, '/items/42');
    });

    test('falls back to home for invalid routes', () {
      expect(AppRoute.parse('/items/not-a-number').isHome, isTrue);
      expect(AppRoute.parse('/items/0').isHome, isTrue);
      expect(AppRoute.parse('/unknown/path').isHome, isTrue);
      expect(AppRoute.parse(null).isHome, isTrue);
    });
  });

  testWidgets('catalog pushes a parameterized detail route', (tester) async {
    await tester.pumpWidget(const NavigationMasteryApp());

    expect(find.text('Navigation Catalog'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('open-item-42')));
    await tester.pumpAndSettle();

    expect(find.text('Item 42'), findsOneWidget);
    expect(find.text('Deep-link item ID: 42'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Navigation Catalog'), findsOneWidget);
  });

  testWidgets('parameterized initial route opens the detail screen', (tester) async {
    await tester.pumpWidget(const NavigationMasteryApp(initialRoute: '/items/7'));
    await tester.pumpAndSettle();

    expect(find.text('Item 7'), findsOneWidget);
    expect(find.text('Deep-link item ID: 7'), findsOneWidget);
  });
}
