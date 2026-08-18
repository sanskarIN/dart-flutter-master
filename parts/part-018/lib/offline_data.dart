import 'dart:convert';

abstract interface class KeyValueStore {
  Future<String?> read(String key);

  Future<void> write(String key, String value);
}

class MemoryKeyValueStore implements KeyValueStore {
  final Map<String, String> _values = <String, String>{};

  @override
  Future<String?> read(String key) async => _values[key];

  @override
  Future<void> write(String key, String value) async {
    _values[key] = value;
  }
}

class Note {
  const Note({required this.id, required this.text, required this.revision});

  final int id;
  final String text;
  final int revision;

  Map<String, Object> toJson() => {
        'id': id,
        'text': text,
        'revision': revision,
      };

  factory Note.fromJson(Map<String, Object?> json) {
    final id = json['id'];
    final text = json['text'];
    final revision = json['revision'];

    if (id is! int || id <= 0 || text is! String || revision is! int || revision < 0) {
      throw const FormatException('Invalid note payload.');
    }

    return Note(id: id, text: text, revision: revision);
  }
}

typedef RemoteNoteLoader = Future<Note> Function();

class OfflineNoteRepository {
  OfflineNoteRepository({
    required KeyValueStore store,
    required RemoteNoteLoader remoteLoader,
    this.cacheKey = 'current-note',
  })  : _store = store,
        _remoteLoader = remoteLoader;

  final KeyValueStore _store;
  final RemoteNoteLoader _remoteLoader;
  final String cacheKey;

  Future<Note?> loadCached() async {
    final raw = await _store.read(cacheKey);
    if (raw == null) return null;

    final decoded = jsonDecode(raw);
    if (decoded is! Map) throw const FormatException('Cached note is not an object.');
    return Note.fromJson(Map<String, Object?>.from(decoded));
  }

  Future<void> saveLocal(Note note) async {
    await _store.write(cacheKey, jsonEncode(note.toJson()));
  }

  Future<Note> refresh() async {
    final note = await _remoteLoader();
    await saveLocal(note);
    return note;
  }
}
