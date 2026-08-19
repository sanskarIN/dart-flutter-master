import 'package:flutter/material.dart';

import 'api_controller.dart';
import 'api_models.dart';

class ApiExplorerApp extends StatelessWidget {
  const ApiExplorerApp({super.key, required this.controller});

  final ApiController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API Explorer',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: ApiExplorerHome(controller: controller),
    );
  }
}

class ApiExplorerHome extends StatefulWidget {
  const ApiExplorerHome({super.key, required this.controller});

  final ApiController controller;

  @override
  State<ApiExplorerHome> createState() => _ApiExplorerHomeState();
}

class _ApiExplorerHomeState extends State<ApiExplorerHome> {
  final _path = TextEditingController(text: '/status');
  HttpVerb _verb = HttpVerb.get;

  @override
  void dispose() {
    _path.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Explorer'),
        actions: [
          IconButton(
            tooltip: 'Clear history',
            onPressed: widget.controller.clearHistory,
            icon: const Icon(Icons.delete_sweep_outlined),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) {
          final controller = widget.controller;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Wrap(
                spacing: 8,
                children: HttpVerb.values
                    .map((verb) => ChoiceChip(
                          label: Text(verb.name.toUpperCase()),
                          selected: _verb == verb,
                          onSelected: (_) => setState(() => _verb = verb),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _path,
                decoration: const InputDecoration(
                  labelText: 'Demo request path',
                  hintText: '/status',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: controller.isLoading ? null : _send,
                icon: const Icon(Icons.send),
                label: const Text('Send demo request'),
              ),
              if (controller.isLoading)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                ),
              if (controller.error case final error?)
                Text(error, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              if (controller.latest case final response?) ...[
                const SizedBox(height: 16),
                Text('Latest response', style: Theme.of(context).textTheme.titleLarge),
                Text('Status ${response.statusCode} • ${response.elapsed.inMilliseconds} ms'),
                const SizedBox(height: 8),
                SelectableText(response.prettyBody),
              ],
              const SizedBox(height: 20),
              Text('History (${controller.history.length})', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              if (controller.history.isEmpty)
                const Text('No requests yet.')
              else
                ...controller.history.map(
                  (exchange) => Card(
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${exchange.response.statusCode}')),
                      title: Text(
                        '${exchange.request.verb.name.toUpperCase()} ${exchange.request.normalizedPath}',
                      ),
                      subtitle: Text('${exchange.response.elapsed.inMilliseconds} ms'),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _send() {
    return widget.controller.execute(ApiRequest(verb: _verb, path: _path.text));
  }
}
