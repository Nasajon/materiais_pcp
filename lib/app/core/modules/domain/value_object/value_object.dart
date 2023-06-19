// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class ValueObject<T> {
  final T value;

  ValueObject(this.value);

  String? errorMessage;
  bool get isValid => errorMessage == null;
  bool get isNotValid => errorMessage != null;

  @override
  String toString() => value.toString();

  @override
  bool operator ==(covariant ValueObject<T> other) {
    if (identical(this, other)) return true;

    return other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
