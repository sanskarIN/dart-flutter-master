import 'package:flutter/material.dart';

import 'offline_data.dart';

class OfflineFirstApp extends StatelessWidget {
  const OfflineFirstApp({required this.repository, super.key});

  final OfflineNoteRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OfflineNoteScreen(repository: repository),
    );
  }
}

class OfflineNoteScreen extends StatefulWidget {
  const OfflineNoteScreen({required this.repository, super.key});

  final OfflineNoteRepository repository;

  @override
  State<OfflineNoteScreen> createState() => _OfflineNoteScreenState();
}

class _OfflineNoteScreenState extends State<OfflineNoteScreen> {
  Note? _note;
  bool _busy = true;
  String? _message;

  @override
  void initState() {
    super.initState();
    _loadCache();
  }

  Future<void> _loadCache() async {
    try {
      final note = await widget.repository.loadCached();
      if (!mounted) return;
      setState(() {
        _note = note;
        _message = note == null ? 'No cached note is available.' : 'Loaded from local cache.';
      });
    } on FormatException {
      if (!mounted) return;
      setState(() => _message = 'Cached data is invalid and needs a refresh.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _busy = true;
      _message = null;
    });

    try {
      final note = await widget.repository.refresh();
      if (!mounted) return;
      setState(() {
        _note = note;
        _message = 'Remote data refreshed and cached locally.';
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _message = 'Refresh failed; cached data remains available.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offline-First Notes')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_busy) const LinearProgressIndicator(),
            const SizedBox(height: 16),
            if (_note != null) ...[
              Text(_note!.text, key: const ValueKey('note-text')),
              const SizedBox(height: 8),
              Text('Revision ${_note!.revision}'),
            ],
            if (_message != null) ...[
              const SizedBox(height: 16),
              Semantics(
                liveRegion: true,
                child: Text(_message!, key: const ValueKey('offline-status')),
              ),
            ],
            const Spacer(),
            FilledButton.icon(
              key: const ValueKey('refresh-note'),
              onPressed: _busy ? null : _refresh,
              icon: const Icon(Icons.sync),
              label: const Text('Refresh remote data'),
            ),
          ],
        ),
      ),
    );
  }
}
