import 'package:flutter/foundation.dart';

import 'ledger_book.dart';
import 'ledger_entry.dart';
import 'ledger_store.dart';

typedef EntryIdFactory = String Function();
typedef LedgerClock = DateTime Function();

class LedgerController extends ChangeNotifier {
  LedgerController({
    required LedgerStore store,
    required EntryIdFactory idFactory,
    required LedgerClock clock,
  })  : _store = store,
        _idFactory = idFactory,
        _clock = clock;

  final LedgerStore _store;
  final EntryIdFactory _idFactory;
  final LedgerClock _clock;

  List<LedgerEntry> _entries = const [];
  String? _error;
  bool _isLoading = false;

  List<LedgerEntry> get entries => List<LedgerEntry>.unmodifiable(_entries);
  LedgerBook get book => LedgerBook(entries);
  String? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    try {
      _entries = await _store.readAll();
      _error = null;
    } catch (_) {
      _error = 'Unable to load ledger entries.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addEntry({
    required String title,
    required int amountPaise,
    required EntryType type,
    required String category,
  }) async {
    final normalizedTitle = title.trim();
    final normalizedCategory = category.trim();
    if (normalizedTitle.isEmpty || normalizedCategory.isEmpty || amountPaise <= 0) {
      _error = 'Enter a valid title, category, and positive amount.';
      notifyListeners();
      return;
    }

    _entries = [
      ..._entries,
      LedgerEntry(
        id: _idFactory(),
        title: normalizedTitle,
        amountPaise: amountPaise,
        type: type,
        category: normalizedCategory,
        occurredAt: _clock(),
      ),
    ];
    await _persist();
  }

  Future<void> removeEntry(String id) async {
    _entries = _entries.where((entry) => entry.id != id).toList();
    await _persist();
  }

  Future<void> _persist() async {
    try {
      await _store.writeAll(_entries);
      _error = null;
    } catch (_) {
      _error = 'Unable to save ledger entries.';
    }
    notifyListeners();
  }
}
