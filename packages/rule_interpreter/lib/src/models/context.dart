/// {@template context}
/// A class that holds the context of a rule.
/// {@endtemplate}
class Context {
  /// {@macro context}
  Context();

  /// The variables stored in the context.
  final Map<String, dynamic> _data = {};

  /// The return value of the rule.
  dynamic returnValue;

  /// Sets a variable in the context.
  void setVariable(String key, dynamic value) {
    _data[key] = value;
  }

  /// Gets a variable from the context.
  T getVariable<T>(String key) {
    return _data[key] as T;
  }
}
