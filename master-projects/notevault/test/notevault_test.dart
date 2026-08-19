import 'package:dfm_notevault/app.dart';
import 'package:dfm_notevault/note_controller.dart';
import 'package:dfm_notevault/note_store.dart';
import 'package:flutter_test/flutter_test.dart';

NoteController buildController() {
  var id = 0;
  var minute = 0;
  return NoteController(
    store: InMemoryNoteStore(),
    idFactory: () => 'note-${id++}',
    clock: () => DateTime.utc(2026, 8, 19, 7, minute++),
  );
}

void main() {
  test('controller creates searchable tagged notes and pins them', () async {
    final controller = buildController();
    await controller.load();

    await controller.addNote(
      title: 'Flutter architecture',
      body: 'Separate state from widgets',
      tags: ['Flutter', 'Architecture'],
    );
    await controller.addNote(
      title: 'Dart streams',
      body: 'Async event pipelines',
      tags: ['Dart'],
    );

    controller.setQuery('architecture');
    expect(controller.visibleNotes.single.title, 'Flutter architecture');

    controller.setQuery('flutter');
    expect(controller.visibleNotes.single.tags, contains('flutter'));

    await controller.togglePinned('note-1');
    controller.setQuery('');
    expect(controller.visibleNotes.first.id, 'note-1');

    await controller.deleteNote('note-0');
    expect(controller.notes.map((note) => note.id), ['note-1']);
  });

  test('empty note is rejected', () async {
    final controller = buildController();
    await controller.load();
    await controller.addNote(title: ' ', body: ' ');
    expect(controller.notes, isEmpty);
    expect(controller.error, isNotNull);
  });

  testWidgets('NoteVault adds and searches notes', (tester) async {
    final controller = buildController();
    await tester.pumpWidget(NoteVaultApp(controller: controller));
    await tester.pump();

    final fields = find.byType(EditableText);
    await tester.enterText(fields.at(1), 'Release checklist');
    await tester.enterText(fields.at(2), 'Run tests and package artifacts');
    await tester.enterText(fields.at(3), 'release, flutter');
    await tester.tap(find.text('Add note'));
    await tester.pump();

    expect(find.text('Release checklist'), findsOneWidget);

    await tester.enterText(fields.at(0), 'missing-query');
    await tester.pump();
    expect(find.text('No notes match this view.'), findsOneWidget);
  });
}
