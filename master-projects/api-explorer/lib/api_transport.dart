import 'api_models.dart';

abstract interface class ApiTransport {
  Future<ApiResponse> send(ApiRequest request);
}

class DemoApiTransport implements ApiTransport {
  const DemoApiTransport();

  @override
  Future<ApiResponse> send(ApiRequest request) async {
    final path = request.normalizedPath;

    if (path == '/fail') {
      return const ApiResponse(
        statusCode: 503,
        body: {'error': 'demo_service_unavailable'},
        elapsed: Duration(milliseconds: 12),
      );
    }

    return ApiResponse(
      statusCode: request.verb == HttpVerb.post ? 201 : 200,
      body: {
        'transport': 'deterministic-demo',
        'method': request.verb.name.toUpperCase(),
        'path': path,
        if (request.body != null) 'echo': request.body,
      },
      elapsed: const Duration(milliseconds: 8),
    );
  }
}
