import 'package:flutter/material.dart';

import 'note_controller.dart';

class NoteVaultApp extends StatelessWidget {
  const NoteVaultApp({super.key, required this.controller});

  final NoteController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NoteVault',
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
      home: NoteVaultHome(controller: controller),
    );
  }
}

class NoteVaultHome extends StatefulWidget {
  const NoteVaultHome({super.key, required this.controller});

  final NoteController controller;

  @override
  State<NoteVaultHome> createState() => _NoteVaultHomeState();
}

class _NoteVaultHomeState extends State<NoteVaultHome> {
  final _title = TextEditingController();
  final _body = TextEditingController();
  final _tags = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.controller.load();
  }

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    _tags.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NoteVault')),
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) {
          final controller = widget.controller;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Search notes',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: controller.setQuery,
              ),
              const SizedBox(height: 16),
              Text('Create note', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              TextField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _body,
                minLines: 2,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'Body'),
              ),
              TextField(
                controller: _tags,
                decoration: const InputDecoration(labelText: 'Tags (comma separated)'),
              ),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: _addNote,
                icon: const Icon(Icons.note_add_outlined),
                label: const Text('Add note'),
              ),
              if (controller.error case final error?)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(error, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                ),
              const SizedBox(height: 20),
              Text(
                'Notes (${controller.visibleNotes.length})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              if (controller.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (controller.visibleNotes.isEmpty)
                const Text('No notes match this view.')
              else
                ...controller.visibleNotes.map(
                  (note) => Card(
                    child: ListTile(
                      leading: Icon(note.isPinned ? Icons.push_pin : Icons.note_outlined),
                      title: Text(note.title.isEmpty ? 'Untitled note' : note.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (note.body.isNotEmpty) Text(note.body, maxLines: 2, overflow: TextOverflow.ellipsis),
                          if (note.tags.isNotEmpty) Text(note.tags.map((tag) => '#$tag').join(' ')),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            tooltip: note.isPinned ? 'Unpin note' : 'Pin note',
                            onPressed: () => controller.togglePinned(note.id),
                            icon: Icon(note.isPinned ? Icons.push_pin : Icons.push_pin_outlined),
                          ),
                          IconButton(
                            tooltip: 'Delete note',
                            onPressed: () => controller.deleteNote(note.id),
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _addNote() async {
    await widget.controller.addNote(
      title: _title.text,
      body: _body.text,
      tags: _tags.text.split(','),
    );
    if (widget.controller.error == null) {
      _title.clear();
      _body.clear();
      _tags.clear();
    }
  }
}
