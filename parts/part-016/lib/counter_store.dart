abstract interface class CounterStore {
  Future<int> read();

  Future<void> write(int value);
}

class MemoryCounterStore implements CounterStore {
  MemoryCounterStore({int initialValue = 0}) : _value = initialValue;

  int _value;

  @override
  Future<int> read() async => _value;

  @override
  Future<void> write(int value) async {
    _value = value;
  }
}
