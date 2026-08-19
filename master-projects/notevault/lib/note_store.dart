import 'note.dart';

abstract interface class NoteStore {
  Future<List<Note>> readAll();
  Future<void> writeAll(List<Note> notes);
}

class InMemoryNoteStore implements NoteStore {
  InMemoryNoteStore([Iterable<Note> seed = const []])
      : _notes = List<Note>.from(seed);

  List<Note> _notes;

  @override
  Future<List<Note>> readAll() async => List<Note>.unmodifiable(_notes);

  @override
  Future<void> writeAll(List<Note> notes) async {
    _notes = List<Note>.from(notes);
  }
}
