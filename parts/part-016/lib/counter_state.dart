enum CounterPhase { idle, loading, ready, error }

class CounterState {
  const CounterState({
    this.count = 0,
    this.phase = CounterPhase.idle,
    this.message,
  });

  final int count;
  final CounterPhase phase;
  final String? message;

  CounterState copyWith({
    int? count,
    CounterPhase? phase,
    String? message,
    bool clearMessage = false,
  }) {
    return CounterState(
      count: count ?? this.count,
      phase: phase ?? this.phase,
      message: clearMessage ? null : (message ?? this.message),
    );
  }
}
