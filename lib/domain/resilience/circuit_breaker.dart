/// Phase 22: In-memory circuit breaker per supplier/source.
/// When failure count exceeds threshold, opens circuit and skips calls until cooldown.
class CircuitBreaker {
  CircuitBreaker({
    this.failureThreshold = 5,
    this.cooldownDuration = const Duration(seconds: 30),
  });

  final int failureThreshold;
  final Duration cooldownDuration;

  int _failureCount = 0;
  DateTime? _lastFailureAt;
  _CircuitState _state = _CircuitState.closed;

  bool get isOpen => _state == _CircuitState.open;
  bool get isHalfOpen => _state == _CircuitState.halfOpen;

  /// Returns true if a call is allowed (closed or half-open and past cooldown).
  bool get canExecute {
    switch (_state) {
      case _CircuitState.closed:
        return true;
      case _CircuitState.open:
        if (_lastFailureAt != null &&
            DateTime.now().difference(_lastFailureAt!) >= cooldownDuration) {
          _state = _CircuitState.halfOpen;
          return true;
        }
        return false;
      case _CircuitState.halfOpen:
        return true;
    }
  }

  void recordSuccess() {
    _failureCount = 0;
    _state = _CircuitState.closed;
  }

  void recordFailure() {
    _lastFailureAt = DateTime.now();
    _failureCount++;
    if (_state == _CircuitState.halfOpen) {
      _state = _CircuitState.open;
      return;
    }
    if (_failureCount >= failureThreshold) {
      _state = _CircuitState.open;
    }
  }
}

enum _CircuitState { closed, open, halfOpen }
