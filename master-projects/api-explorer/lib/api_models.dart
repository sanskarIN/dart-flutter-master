import 'dart:convert';

enum HttpVerb { get, post, put, delete }

class ApiRequest {
  const ApiRequest({
    required this.verb,
    required this.path,
    this.body,
  });

  final HttpVerb verb;
  final String path;
  final Map<String, Object?>? body;

  String get normalizedPath {
    final trimmed = path.trim();
    if (trimmed.isEmpty) return '/';
    return trimmed.startsWith('/') ? trimmed : '/$trimmed';
  }
}

class ApiResponse {
  const ApiResponse({
    required this.statusCode,
    required this.body,
    required this.elapsed,
  });

  final int statusCode;
  final Object? body;
  final Duration elapsed;

  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  String get prettyBody => const JsonEncoder.withIndent('  ').convert(body);
}

class ApiExchange {
  const ApiExchange({required this.request, required this.response});

  final ApiRequest request;
  final ApiResponse response;
}
