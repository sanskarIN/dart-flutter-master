import 'ledger_entry.dart';

class LedgerBook {
  const LedgerBook(this.entries);

  final List<LedgerEntry> entries;

  int get incomePaise => entries
      .where((entry) => entry.type == EntryType.income)
      .fold(0, (sum, entry) => sum + entry.amountPaise);

  int get expensePaise => entries
      .where((entry) => entry.type == EntryType.expense)
      .fold(0, (sum, entry) => sum + entry.amountPaise);

  int get balancePaise => incomePaise - expensePaise;

  Map<String, int> expenseByCategory() {
    final totals = <String, int>{};
    for (final entry in entries.where((entry) => entry.type == EntryType.expense)) {
      totals.update(
        entry.category,
        (value) => value + entry.amountPaise,
        ifAbsent: () => entry.amountPaise,
      );
    }
    return totals;
  }

  List<LedgerEntry> entriesForMonth(int year, int month) {
    return entries
        .where((entry) => entry.occurredAt.year == year && entry.occurredAt.month == month)
        .toList()
      ..sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
  }
}
