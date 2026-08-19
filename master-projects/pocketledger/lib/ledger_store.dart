import 'ledger_entry.dart';

abstract interface class LedgerStore {
  Future<List<LedgerEntry>> readAll();
  Future<void> writeAll(List<LedgerEntry> entries);
}

class InMemoryLedgerStore implements LedgerStore {
  InMemoryLedgerStore([Iterable<LedgerEntry> seed = const []])
      : _entries = List<LedgerEntry>.from(seed);

  List<LedgerEntry> _entries;

  @override
  Future<List<LedgerEntry>> readAll() async => List<LedgerEntry>.unmodifiable(_entries);

  @override
  Future<void> writeAll(List<LedgerEntry> entries) async {
    _entries = List<LedgerEntry>.from(entries);
  }
}
