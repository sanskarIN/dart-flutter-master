import 'package:flutter/material.dart';

import 'offline_data.dart';
import 'part_018.dart';

void main() {
  final repository = OfflineNoteRepository(
    store: MemoryKeyValueStore(),
    remoteLoader: () async => const Note(
      id: 1,
      text: 'Remote note synchronized into the local cache.',
      revision: 1,
    ),
  );

  runApp(OfflineFirstApp(repository: repository));
}
