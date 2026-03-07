/// Simple token-bucket rate limiter for API calls.
class RateLimiter {
  RateLimiter({
    this.maxRequests = 10,
    this.window = const Duration(seconds: 1),
  });

  final int maxRequests;
  final Duration window;
  final List<DateTime> _timestamps = [];

  /// Wait if necessary to stay within rate limit, then proceed.
  Future<void> acquire() async {
    _timestamps.removeWhere(
      (t) => DateTime.now().difference(t) > window,
    );
    if (_timestamps.length >= maxRequests) {
      final oldest = _timestamps.first;
      final waitTime = window - DateTime.now().difference(oldest);
      if (waitTime > Duration.zero) {
        await Future.delayed(waitTime);
      }
      _timestamps.removeWhere(
        (t) => DateTime.now().difference(t) > window,
      );
    }
    _timestamps.add(DateTime.now());
  }
}
