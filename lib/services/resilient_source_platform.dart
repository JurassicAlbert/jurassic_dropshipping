import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';
import 'package:jurassic_dropshipping/domain/resilience/circuit_breaker.dart';
import 'package:jurassic_dropshipping/domain/resilience/circuit_breaker_registry.dart';
import 'package:jurassic_dropshipping/domain/resilience/retry_policy.dart';

/// Phase 22: Wraps a [SourcePlatform] with circuit breaker and retry. Does not replace the inner source.
class ResilientSourcePlatform implements SourcePlatform {
  ResilientSourcePlatform(
    this._inner, {
    required CircuitBreakerRegistry circuitRegistry,
    RetryPolicy? retryPolicy,
  })  : _circuit = circuitRegistry.getOrCreate(_inner.id),
        _retry = retryPolicy ?? RetryPolicy();

  final SourcePlatform _inner;
  final CircuitBreaker _circuit;
  final RetryPolicy _retry;

  @override
  String get id => _inner.id;

  @override
  String get displayName => _inner.displayName;

  @override
  Future<bool> isConfigured() => _inner.isConfigured();

  @override
  Future<List<Product>> searchProducts(
    List<String> keywords, {
    SourceSearchFilters? filters,
  }) async {
    return _withResilience(() => _inner.searchProducts(keywords, filters: filters));
  }

  @override
  Future<Product?> getProduct(String sourceId) async {
    return _withResilience(() => _inner.getProduct(sourceId));
  }

  @override
  Future<Product?> getBestOffer(String productId) async {
    return _withResilience(() => _inner.getBestOffer(productId));
  }

  @override
  Future<SourceOrderResult> placeOrder(PlaceOrderRequest request) async {
    return _withResilience(() => _inner.placeOrder(request));
  }

  @override
  Future<SourceOrderResult?> getOrderStatus(String sourceOrderId) async {
    return _withResilience(() => _inner.getOrderStatus(sourceOrderId));
  }

  @override
  Future<bool> cancelOrder(String sourceOrderId) async {
    return _withResilience(() => _inner.cancelOrder(sourceOrderId));
  }

  Future<T> _withResilience<T>(Future<T> Function() fn) async {
    if (!_circuit.canExecute) {
      appLogger.w('ResilientSource: circuit open for ${_inner.id}, skipping call');
      throw CircuitOpenException(_inner.id);
    }
    try {
      final result = await _retry.execute(fn);
      _circuit.recordSuccess();
      return result;
    } catch (e, st) {
      _circuit.recordFailure();
      appLogger.d('ResilientSource: ${_inner.id} call failed (circuit recorded)', error: e, stackTrace: st);
      rethrow;
    }
  }
}

/// Thrown when the circuit is open and the call was skipped.
class CircuitOpenException implements Exception {
  CircuitOpenException(this.sourceId);
  final String sourceId;
  @override
  String toString() => 'CircuitOpenException(sourceId: $sourceId)';
}
