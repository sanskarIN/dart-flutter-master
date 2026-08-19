import 'package:flutter/foundation.dart';

import 'api_models.dart';
import 'api_transport.dart';

class ApiController extends ChangeNotifier {
  ApiController({required ApiTransport transport}) : _transport = transport;

  final ApiTransport _transport;

  final List<ApiExchange> _history = [];
  ApiResponse? _latest;
  String? _error;
  bool _isLoading = false;

  List<ApiExchange> get history => List<ApiExchange>.unmodifiable(_history);
  ApiResponse? get latest => _latest;
  String? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> execute(ApiRequest request) async {
    if (request.path.trim().isEmpty) {
      _error = 'Enter a request path.';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _transport.send(request);
      _latest = response;
      _history.insert(0, ApiExchange(request: request, response: response));
      if (_history.length > 20) {
        _history.removeRange(20, _history.length);
      }
    } catch (_) {
      _error = 'The transport failed before a response was produced.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearHistory() {
    _history.clear();
    _latest = null;
    _error = null;
    notifyListeners();
  }
}
