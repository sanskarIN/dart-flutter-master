import 'package:flutter/foundation.dart';

import 'counter_state.dart';
import 'counter_store.dart';

class CounterController extends ChangeNotifier {
  CounterController(this._store);

  final CounterStore _store;
  CounterState _state = const CounterState();

  CounterState get state => _state;

  Future<void> load() async {
    _setState(_state.copyWith(phase: CounterPhase.loading, clearMessage: true));
    try {
      final value = await _store.read();
      _setState(CounterState(count: value, phase: CounterPhase.ready));
    } catch (_) {
      _setState(
        _state.copyWith(
          phase: CounterPhase.error,
          message: 'Could not load saved state.',
        ),
      );
    }
  }

  Future<void> increment() async {
    if (_state.phase == CounterPhase.loading) return;

    final next = _state.count + 1;
    _setState(_state.copyWith(count: next, phase: CounterPhase.ready, clearMessage: true));

    try {
      await _store.write(next);
    } catch (_) {
      _setState(
        _state.copyWith(
          phase: CounterPhase.error,
          message: 'The new value could not be saved.',
        ),
      );
    }
  }

  void _setState(CounterState value) {
    _state = value;
    notifyListeners();
  }
}
