import 'package:dfm_part_019/native_capability.dart';
import 'package:dfm_part_019/part_019.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeNativeCapability implements NativeCapability {
  FakeNativeCapability(this.result);

  final Future<String> Function() result;

  @override
  Future<String> platformName() => result();
}

void main() {
  test('safe service returns successful native values', () async {
    final service = SafePlatformService(
      FakeNativeCapability(() async => 'Android'),
    );

    expect(await service.loadPlatformLabel(), 'Android');
  });

  test('safe service converts MissingPluginException into a fallback', () async {
    final service = SafePlatformService(
      FakeNativeCapability(() async => throw MissingPluginException()),
    );

    expect(
      await service.loadPlatformLabel(),
      'Native capability is unavailable in this app shell.',
    );
  });

  test('safe service converts PlatformException into a readable failure', () async {
    final service = SafePlatformService(
      FakeNativeCapability(
        () async => throw PlatformException(code: 'native_error'),
      ),
    );

    expect(
      await service.loadPlatformLabel(),
      'Native capability failed (native_error).',
    );
  });

  testWidgets('screen requests an injected native capability', (tester) async {
    final service = SafePlatformService(
      FakeNativeCapability(() async => 'Windows'),
    );

    await tester.pumpWidget(PlatformIntegrationApp(service: service));
    await tester.tap(find.byKey(const ValueKey('load-platform')));
    await tester.pumpAndSettle();

    expect(find.text('Windows'), findsOneWidget);
  });
}
