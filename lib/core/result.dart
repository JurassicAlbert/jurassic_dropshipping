import 'app_error.dart';

/// Result type for operations that can fail.
sealed class Result<T, E extends AppError> {
  const Result();
  R when<R>({
    required R Function(T value) ok,
    required R Function(E error) err,
  });
}

final class Ok<T, E extends AppError> extends Result<T, E> {
  const Ok(this.value);
  final T value;
  @override
  R when<R>({
    required R Function(T value) ok,
    required R Function(E error) err,
  }) =>
      ok(value);
}

final class Err<T, E extends AppError> extends Result<T, E> {
  const Err(this.error);
  final E error;
  @override
  R when<R>({
    required R Function(T value) ok,
    required R Function(E error) err,
  }) =>
      err(error);
}

extension ResultExtension<T, E extends AppError> on Result<T, E> {
  T? get valueOrNull =>
      this is Ok<T, E> ? (this as Ok<T, E>).value : null;
  E? get errorOrNull =>
      this is Err<T, E> ? (this as Err<T, E>).error : null;
  bool get isOk => this is Ok<T, E>;
  bool get isErr => this is Err<T, E>;
}
