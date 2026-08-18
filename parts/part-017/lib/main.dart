import 'package:flutter/material.dart';

import 'networking.dart';
import 'part_017.dart';

void main() {
  final api = ArticleApi(
    baseUri: Uri.parse('https://example.invalid'),
    transport: (uri) async => const RestResponse(
      statusCode: 200,
      body: '[{"id":1,"title":"Dependency boundaries"},{"id":2,"title":"Resilient decoding"}]',
    ),
  );

  runApp(NetworkingMasteryApp(repository: ArticleRepository(api)));
}
