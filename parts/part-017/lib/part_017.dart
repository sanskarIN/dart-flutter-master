import 'package:flutter/material.dart';

import 'networking.dart';

class NetworkingMasteryApp extends StatelessWidget {
  const NetworkingMasteryApp({required this.repository, super.key});

  final ArticleRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ArticleScreen(repository: repository),
    );
  }
}

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({required this.repository, super.key});

  final ArticleRepository repository;

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  bool _loading = true;
  String? _error;
  List<Article> _articles = const [];

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final articles = await widget.repository.refresh();
      if (!mounted) return;
      setState(() => _articles = articles);
    } on ApiFailure catch (error) {
      if (!mounted) return;
      setState(() => _error = error.message);
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = 'Unexpected networking failure.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resilient REST Architecture'),
        actions: [
          IconButton(
            key: const ValueKey('refresh-button'),
            onPressed: _loading ? null : _refresh,
            tooltip: 'Refresh articles',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      _error!,
                      key: const ValueKey('network-error'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _articles.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final article = _articles[index];
                    return ListTile(
                      title: Text(article.title),
                      subtitle: Text('Article #${article.id}'),
                    );
                  },
                ),
    );
  }
}
