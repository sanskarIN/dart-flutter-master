import 'package:flutter/material.dart';

import 'app.dart';
import 'note_controller.dart';
import 'note_store.dart';

void main() {
  var nextId = 0;
  final controller = NoteController(
    store: InMemoryNoteStore(),
    idFactory: () => 'note-${nextId++}',
    clock: DateTime.now,
  );

  runApp(NoteVaultApp(controller: controller));
}
