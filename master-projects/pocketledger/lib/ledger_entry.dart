enum EntryType { income, expense }

class LedgerEntry {
  const LedgerEntry({
    required this.id,
    required this.title,
    required this.amountPaise,
    required this.type,
    required this.category,
    required this.occurredAt,
  }) : assert(amountPaise > 0);

  final String id;
  final String title;
  final int amountPaise;
  final EntryType type;
  final String category;
  final DateTime occurredAt;

  int get signedPaise => type == EntryType.income ? amountPaise : -amountPaise;
}

String formatInr(int paise) {
  final sign = paise < 0 ? '-' : '';
  final absolute = paise.abs();
  final rupees = absolute ~/ 100;
  final remainder = absolute % 100;
  return '$sign₹$rupees.${remainder.toString().padLeft(2, '0')}';
}
