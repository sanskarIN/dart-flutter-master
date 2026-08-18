String slugify(String input) {
  final normalized = input.trim().toLowerCase();
  if (normalized.isEmpty) return '';

  return normalized
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
}
