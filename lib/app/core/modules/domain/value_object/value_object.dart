abstract class ValueObject<T> {
  final T value;

  ValueObject(this.value);

  String? errorMessage;
  bool get isValid => errorMessage == null;
  bool get isNotValid => errorMessage != null;

  @override
  String toString() => value.toString();
}
