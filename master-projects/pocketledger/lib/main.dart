import 'package:flutter/material.dart';

import 'app.dart';
import 'ledger_controller.dart';
import 'ledger_store.dart';

void main() {
  var nextId = 0;
  final controller = LedgerController(
    store: InMemoryLedgerStore(),
    idFactory: () => 'entry-${nextId++}',
    clock: DateTime.now,
  );

  runApp(PocketLedgerApp(controller: controller));
}
