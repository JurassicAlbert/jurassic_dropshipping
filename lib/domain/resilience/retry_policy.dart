import 'package:dio/dio.dart';

/// Phase 22: Retry with backoff for transient supplier API failures.
class RetryPolicy {
  RetryPolicy({
    this.maxAttempts = 3,
    this.initialDelay = const Duration(milliseconds: 500),
    this.maxDelay = const Duration(seconds: 10),
    this.backoffMultiplier = 2.0,
  });

  final int maxAttempts;
  final Duration initialDelay;
  final Duration maxDelay;
  final double backoffMultiplier;

  /// True if [error] is likely transient (network, timeout, 5xx).
  static bool isTransient(Object error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionError:
          return true;
        case DioExceptionType.badResponse:
          final status = error.response?.statusCode;
          return status != null && status >= 500 && status < 600;
        default:
          return false;
      }
    }
    final msg = error.toString().toLowerCase();
    return msg.contains('timeout') ||
        msg.contains('socket') ||
        msg.contains('connection') ||
        msg.contains('network');
  }

  /// Runs [fn] with retries on transient errors. Rethrows on non-transient or when max attempts exceeded.
  Future<T> execute<T>(Future<T> Function() fn) async {
    Object? lastError;
    var delay = initialDelay;
    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        return await fn();
      } catch (e) {
        lastError = e;
        if (attempt == maxAttempts || !isTransient(e)) {
          break;
        }
        if (attempt < maxAttempts) {
          await Future<void>.delayed(delay);
          delay = Duration(
            milliseconds: (delay.inMilliseconds * backoffMultiplier).round().clamp(0, maxDelay.inMilliseconds),
          );
        }
      }
    }
    throw lastError!;
  }
}
