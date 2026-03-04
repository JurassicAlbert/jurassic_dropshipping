/// Domain errors for the app.
sealed class AppError {
  const AppError();
  String get message;
}

final class NetworkError extends AppError {
  const NetworkError([this.detail]);
  final String? detail;
  @override
  String get message => 'Network error${detail != null ? ': $detail' : ''}';
}

final class ApiError extends AppError {
  const ApiError(this.statusCode, this.detail);
  final int statusCode;
  final String? detail;
  @override
  String get message =>
      'API error ($statusCode)${detail != null ? ': $detail' : ''}';
}

final class ValidationError extends AppError {
  const ValidationError(this.detail);
  final String detail;
  @override
  String get message => 'Validation error: $detail';
}

final class NotFoundError extends AppError {
  const NotFoundError(this.resource);
  final String resource;
  @override
  String get message => 'Not found: $resource';
}

final class StorageError extends AppError {
  const StorageError(this.detail);
  final String detail;
  @override
  String get message => 'Storage error: $detail';
}

final class UnauthorizedError extends AppError {
  const UnauthorizedError([this.platform]);
  final String? platform;
  @override
  String get message =>
      'Unauthorized${platform != null ? ' ($platform)' : ''}';
}
