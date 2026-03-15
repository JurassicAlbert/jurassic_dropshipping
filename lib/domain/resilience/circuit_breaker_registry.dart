import 'package:jurassic_dropshipping/domain/resilience/circuit_breaker.dart';

/// Phase 22: Registry of circuit breakers per source platform id.
class CircuitBreakerRegistry {
  final Map<String, CircuitBreaker> _byId = {};

  CircuitBreaker getOrCreate(String sourceId, {int failureThreshold = 5, Duration cooldownDuration = const Duration(seconds: 30)}) {
    return _byId.putIfAbsent(
      sourceId,
      () => CircuitBreaker(failureThreshold: failureThreshold, cooldownDuration: cooldownDuration),
    );
  }

  CircuitBreaker? get(String sourceId) => _byId[sourceId];
}
