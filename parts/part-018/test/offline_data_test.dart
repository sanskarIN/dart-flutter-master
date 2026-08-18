import 'package:dfm_part_018/offline_data.dart';
import 'package:dfm_part_018/part_018.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('local-first writes can be loaded without a remote request', () async {
    var remoteCalls = 0;
    final repository = OfflineNoteRepository(
      store: MemoryKeyValueStore(),
      remoteLoader: () async {
        remoteCalls++;
        return const Note(id: 9, text: 'Remote', revision: 2);
      },
    );

    const draft = Note(id: 1, text: 'Offline draft', revision: 1);
    await repository.saveLocal(draft);

    final cached = await repository.loadCached();
    expect(cached?.text, 'Offline draft');
    expect(remoteCalls, 0);
  });

  test('refresh stores the newest remote value locally', () async {
    final repository = OfflineNoteRepository(
      store: MemoryKeyValueStore(),
      remoteLoader: () async => const Note(id: 2, text: 'Fresh', revision: 3),
    );

    final refreshed = await repository.refresh();
    final cached = await repository.loadCached();

    expect(refreshed.text, 'Fresh');
    expect(cached?.revision, 3);
  });

  testWidgets('screen loads cached data first', (tester) async {
    final store = MemoryKeyValueStore();
    final repository = OfflineNoteRepository(
      store: store,
      remoteLoader: () async => const Note(id: 2, text: 'Remote', revision: 2),
    );
    await repository.saveLocal(const Note(id: 1, text: 'Cached note', revision: 1));

    await tester.pumpWidget(OfflineFirstApp(repository: repository));
    await tester.pumpAndSettle();

    expect(find.text('Cached note'), findsOneWidget);
    expect(find.text('Loaded from local cache.'), findsOneWidget);
  });

  testWidgets('manual refresh updates and caches remote data', (tester) async {
    final store = MemoryKeyValueStore();
    final repository = OfflineNoteRepository(
      store: store,
      remoteLoader: () async => const Note(id: 3, text: 'Synced note', revision: 4),
    );

    await tester.pumpWidget(OfflineFirstApp(repository: repository));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('refresh-note')));
    await tester.pumpAndSettle();

    expect(find.text('Synced note'), findsOneWidget);
    expect(find.text('Remote data refreshed and cached locally.'), findsOneWidget);
    expect((await repository.loadCached())?.revision, 4);
  });
}
