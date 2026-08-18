import 'dart:convert';

typedef RestTransport = Future<RestResponse> Function(Uri uri);

class RestResponse {
  const RestResponse({required this.statusCode, required this.body});

  final int statusCode;
  final String body;
}

class ApiFailure implements Exception {
  ApiFailure(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'ApiFailure($statusCode): $message';
}

class Article {
  const Article({required this.id, required this.title});

  final int id;
  final String title;

  factory Article.fromJson(Map<String, Object?> json) {
    final id = json['id'];
    final title = json['title'];
    if (id is! int || title is! String || title.trim().isEmpty) {
      throw ApiFailure('Article payload is missing required fields.');
    }
    return Article(id: id, title: title.trim());
  }
}

class ArticleApi {
  ArticleApi({required this.baseUri, required RestTransport transport})
      : _transport = transport;

  final Uri baseUri;
  final RestTransport _transport;

  Future<List<Article>> fetchArticles() async {
    final uri = baseUri.resolve('/articles');
    final response = await _transport(uri);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiFailure(
        'Request failed with HTTP ${response.statusCode}.',
        statusCode: response.statusCode,
      );
    }

    final Object? decoded;
    try {
      decoded = jsonDecode(response.body);
    } on FormatException {
      throw ApiFailure('Response body was not valid JSON.');
    }

    if (decoded is! List) {
      throw ApiFailure('Expected a JSON list.');
    }

    return decoded
        .map((item) {
          if (item is! Map) throw ApiFailure('Expected an article object.');
          return Article.fromJson(Map<String, Object?>.from(item));
        })
        .toList(growable: false);
  }
}

class ArticleRepository {
  ArticleRepository(this._api);

  final ArticleApi _api;
  List<Article> _cache = const [];

  List<Article> get cachedArticles => List<Article>.unmodifiable(_cache);

  Future<List<Article>> refresh() async {
    final articles = await _api.fetchArticles();
    _cache = articles;
    return cachedArticles;
  }
}
