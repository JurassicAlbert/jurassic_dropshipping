import 'package:dio/dio.dart';
import 'package:jurassic_dropshipping/core/logger.dart';

/// Dio interceptor that retries failed requests with exponential backoff.
class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    this.maxRetries = 3,
    this.baseDelay = const Duration(seconds: 1),
    this.retryableStatuses = const {408, 429, 500, 502, 503, 504},
  });

  final int maxRetries;
  final Duration baseDelay;
  final Set<int> retryableStatuses;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final isRetryable = statusCode != null && retryableStatuses.contains(statusCode);
    final isTimeout = err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout;

    if (!isRetryable && !isTimeout) {
      return handler.next(err);
    }

    final retryCount = err.requestOptions.extra['_retryCount'] as int? ?? 0;
    if (retryCount >= maxRetries) {
      appLogger.w('RetryInterceptor: max retries ($maxRetries) exceeded for ${err.requestOptions.path}');
      return handler.next(err);
    }

    final delay = baseDelay * (1 << retryCount); // exponential backoff
    appLogger.i('RetryInterceptor: retry ${retryCount + 1}/$maxRetries for ${err.requestOptions.path} in ${delay.inMilliseconds}ms');
    await Future.delayed(delay);

    err.requestOptions.extra['_retryCount'] = retryCount + 1;
    try {
      final dio = Dio(BaseOptions(
        baseUrl: err.requestOptions.baseUrl,
        headers: err.requestOptions.headers,
        connectTimeout: err.requestOptions.connectTimeout,
        receiveTimeout: err.requestOptions.receiveTimeout,
      ));
      final response = await dio.fetch(err.requestOptions);
      return handler.resolve(response);
    } catch (e) {
      if (e is DioException) {
        return onError(e, handler);
      }
      return handler.next(err);
    }
  }
}
