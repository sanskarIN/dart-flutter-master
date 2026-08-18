import 'package:flutter/material.dart';

class LayoutMasteryApp extends StatelessWidget {
  const LayoutMasteryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResponsiveLayoutScreen(),
    );
  }
}

class ResponsiveLayoutScreen extends StatelessWidget {
  const ResponsiveLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 900;
          final content = const Expanded(child: LearningSliverView());

          if (wide) {
            return Row(
              children: [
                const NavigationRail(
                  selectedIndex: 0,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.dashboard_outlined),
                      selectedIcon: Icon(Icons.dashboard),
                      label: Text('Layout'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.view_quilt_outlined),
                      selectedIcon: Icon(Icons.view_quilt),
                      label: Text('Slivers'),
                    ),
                  ],
                ),
                content,
              ],
            );
          }

          return const LearningSliverView();
        },
      ),
    );
  }
}

class LearningSliverView extends StatelessWidget {
  const LearningSliverView({super.key});

  static const topics = [
    'Constraints',
    'LayoutBuilder',
    'Responsive breakpoints',
    'SliverAppBar',
    'SliverGrid',
    'Adaptive density',
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          pinned: true,
          title: Text('Responsive Layout'),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverLayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.crossAxisExtent;
              final columns = width >= 1000
                  ? 3
                  : width >= 600
                      ? 2
                      : 1;

              return SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.4,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => LayoutTopicCard(title: topics[index]),
                  childCount: topics.length,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class LayoutTopicCard extends StatelessWidget {
  const LayoutTopicCard({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(title, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
