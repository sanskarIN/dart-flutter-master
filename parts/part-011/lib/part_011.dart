import 'package:flutter/material.dart';

class MasteryApp extends StatelessWidget {
  const MasteryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WidgetPipelineDemo(),
    );
  }
}

class WidgetPipelineDemo extends StatelessWidget {
  const WidgetPipelineDemo({super.key});

  static const List<(String, String)> concepts = [
    (
      'Widget',
      'Immutable configuration that describes part of the user interface.',
    ),
    (
      'Element',
      'The mounted instance that connects a widget to the live tree.',
    ),
    (
      'Render object',
      'The lower-level object responsible for layout, painting, and hit testing.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter UI Pipeline')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: concepts.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final (title, description) = concepts[index];
          return ConceptCard(title: title, description: description);
        },
      ),
    );
  }
}

class ConceptCard extends StatelessWidget {
  const ConceptCard({
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(description),
          ],
        ),
      ),
    );
  }
}
