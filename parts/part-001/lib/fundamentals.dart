/// Returns a friendly greeting for a non-empty [name].
String buildGreeting(String name) {
  final normalized = name.trim();
  if (normalized.isEmpty) {
    throw ArgumentError.value(name, 'name', 'must not be empty');
  }
  return 'Hello, $normalized! Welcome to Dart.';
}

/// Converts Celsius to Fahrenheit.
double celsiusToFahrenheit(num celsius) => (celsius * 9 / 5) + 32;

/// Returns whether [value] is even.
bool isEven(int value) => value.isEven;
