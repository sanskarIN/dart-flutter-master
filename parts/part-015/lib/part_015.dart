import 'package:flutter/material.dart';

import 'app_route.dart';

class NavigationMasteryApp extends StatelessWidget {
  const NavigationMasteryApp({super.key, this.initialRoute = '/'});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      onGenerateRoute: buildAppRoute,
    );
  }
}

Route<dynamic> buildAppRoute(RouteSettings settings) {
  final route = AppRoute.parse(settings.name);

  return MaterialPageRoute<void>(
    settings: settings,
    builder: (context) {
      final itemId = route.itemId;
      return itemId == null ? const CatalogScreen() : ItemDetailScreen(itemId: itemId);
    },
  );
}

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Open a parameterized route using Navigator.'),
          const SizedBox(height: 16),
          FilledButton(
            key: const ValueKey('open-item-42'),
            onPressed: () => Navigator.of(context).pushNamed('/items/42'),
            child: const Text('Open item 42'),
          ),
        ],
      ),
    );
  }
}

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({required this.itemId, super.key});

  final int itemId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Item $itemId')),
      body: Center(
        child: Text(
          'Deep-link item ID: $itemId',
          key: const ValueKey('detail-id'),
        ),
      ),
    );
  }
}
