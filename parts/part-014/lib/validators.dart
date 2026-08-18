String? validateName(String? value) {
  final normalized = value?.trim() ?? '';
  if (normalized.isEmpty) return 'Enter your name.';
  if (normalized.length < 2) return 'Name must contain at least 2 characters.';
  return null;
}

String? validateEmail(String? value) {
  final normalized = value?.trim() ?? '';
  if (normalized.isEmpty) return 'Enter your email address.';

  final atIndex = normalized.indexOf('@');
  final dotIndex = normalized.lastIndexOf('.');
  final looksValid = atIndex > 0 && dotIndex > atIndex + 1 && dotIndex < normalized.length - 1;

  return looksValid ? null : 'Enter a valid email address.';
}
