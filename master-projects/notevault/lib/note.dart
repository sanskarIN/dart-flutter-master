class Note {
  const Note({
    required this.id,
    required this.title,
    required this.body,
    required this.updatedAt,
    this.tags = const <String>{},
    this.isPinned = false,
  });

  final String id;
  final String title;
  final String body;
  final DateTime updatedAt;
  final Set<String> tags;
  final bool isPinned;

  Note copyWith({
    String? title,
    String? body,
    DateTime? updatedAt,
    Set<String>? tags,
    bool? isPinned,
  }) {
    return Note(
      id: id,
      title: title ?? this.title,
      body: body ?? this.body,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
      isPinned: isPinned ?? this.isPinned,
    );
  }

  bool matches(String rawQuery) {
    final query = rawQuery.trim().toLowerCase();
    if (query.isEmpty) return true;
    return title.toLowerCase().contains(query) ||
        body.toLowerCase().contains(query) ||
        tags.any((tag) => tag.toLowerCase().contains(query));
  }
}
