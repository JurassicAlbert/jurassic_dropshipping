import 'package:dio/dio.dart';
import 'package:jurassic_dropshipping/services/rate_limiter.dart';

/// Dio interceptor that throttles outgoing requests using a RateLimiter.
class RateLimitInterceptor extends Interceptor {
  RateLimitInterceptor({RateLimiter? limiter})
      : _limiter = limiter ?? RateLimiter(maxRequests: 5, window: const Duration(seconds: 1));

  final RateLimiter _limiter;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    await _limiter.acquire();
    handler.next(options);
  }
}
