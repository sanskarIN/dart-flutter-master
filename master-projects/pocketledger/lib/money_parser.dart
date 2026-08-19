int? parseRupeesToPaise(String raw) {
  final value = raw.trim().replaceAll(',', '');
  final match = RegExp(r'^([0-9]+)(?:\.([0-9]{1,2}))?$').firstMatch(value);
  if (match == null) return null;

  final rupees = int.parse(match.group(1)!);
  final decimal = match.group(2) ?? '';
  final paise = decimal.isEmpty
      ? 0
      : int.parse(decimal.length == 1 ? '${decimal}0' : decimal);
  final total = rupees * 100 + paise;
  return total > 0 ? total : null;
}
