import 'package:flutter/foundation.dart';

import 'note.dart';
import 'note_store.dart';

typedef NoteIdFactory = String Function();
typedef NoteClock = DateTime Function();

class NoteController extends ChangeNotifier {
  NoteController({
    required NoteStore store,
    required NoteIdFactory idFactory,
    required NoteClock clock,
  })  : _store = store,
        _idFactory = idFactory,
        _clock = clock;

  final NoteStore _store;
  final NoteIdFactory _idFactory;
  final NoteClock _clock;

  List<Note> _notes = const [];
  String _query = '';
  String? _error;
  bool _isLoading = false;

  List<Note> get notes => List<Note>.unmodifiable(_notes);
  String get query => _query;
  String? get error => _error;
  bool get isLoading => _isLoading;

  List<Note> get visibleNotes {
    final result = _notes.where((note) => note.matches(_query)).toList();
    result.sort((a, b) {
      if (a.isPinned != b.isPinned) return a.isPinned ? -1 : 1;
      return b.updatedAt.compareTo(a.updatedAt);
    });
    return result;
  }

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    try {
      _notes = await _store.readAll();
      _error = null;
    } catch (_) {
      _error = 'Unable to load notes.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addNote({
    required String title,
    required String body,
    Iterable<String> tags = const [],
  }) async {
    final normalizedTitle = title.trim();
    final normalizedBody = body.trim();
    if (normalizedTitle.isEmpty && normalizedBody.isEmpty) {
      _error = 'A note needs a title or body.';
      notifyListeners();
      return;
    }

    final normalizedTags = tags
        .map((tag) => tag.trim().toLowerCase())
        .where((tag) => tag.isNotEmpty)
        .toSet();

    _notes = [
      ..._notes,
      Note(
        id: _idFactory(),
        title: normalizedTitle,
        body: normalizedBody,
        updatedAt: _clock(),
        tags: Set<String>.unmodifiable(normalizedTags),
      ),
    ];
    await _persist();
  }

  Future<void> togglePinned(String id) async {
    _notes = [
      for (final note in _notes)
        if (note.id == id)
          note.copyWith(isPinned: !note.isPinned, updatedAt: _clock())
        else
          note,
    ];
    await _persist();
  }

  Future<void> deleteNote(String id) async {
    _notes = _notes.where((note) => note.id != id).toList();
    await _persist();
  }

  void setQuery(String value) {
    if (_query == value) return;
    _query = value;
    notifyListeners();
  }

  Future<void> _persist() async {
    try {
      await _store.writeAll(_notes);
      _error = null;
    } catch (_) {
      _error = 'Unable to save notes.';
    }
    notifyListeners();
  }
}
