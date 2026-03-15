import 'package:jurassic_dropshipping/data/repositories/financial_ledger_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';

/// Tracks available capital from ledger; gates fulfillment when capital is insufficient (Phase 14).
class CapitalManagementService {
  CapitalManagementService(this._ledger, this._orderRepo);

  final FinancialLedgerRepository _ledger;
  final OrderRepository _orderRepo;

  /// Current available capital (ledger balance). Positive = can spend.
  Future<double> getAvailableCapital() async => _ledger.getBalance();

  /// True if [orderCost] can be covered by available capital.
  Future<bool> canFulfillOrder(double orderCost) async {
    final balance = await getAvailableCapital();
    return balance >= orderCost;
  }

  /// Records supplier payment (outflow). Call after placing source order.
  /// Appends ledger entry and sets order financial state to supplier_paid.
  Future<void> recordSupplierPaid(String orderId, double amount, {String? referenceId}) async {
    await _ledger.append(
      type: LedgerEntryType.supplierPrepayment.name,
      amount: -amount,
      orderId: orderId,
      referenceId: referenceId,
    );
    await _orderRepo.updateFinancialState(orderId, 'supplier_paid');
  }

  /// Records marketplace payout (inflow). Call when marketplace releases funds.
  Future<void> recordMarketplaceReleased(double amount, {String? orderId, String? referenceId}) async {
    await _ledger.append(
      type: LedgerEntryType.marketplaceReleased.name,
      amount: amount,
      orderId: orderId,
      referenceId: referenceId,
    );
    if (orderId != null) {
      await _orderRepo.updateFinancialState(orderId, 'marketplace_released');
    }
  }

  /// Records refund (outflow). Call when issuing refund.
  Future<void> recordRefund(String orderId, double amount, {String? referenceId}) async {
    await _ledger.append(
      type: LedgerEntryType.refund.name,
      amount: -amount,
      orderId: orderId,
      referenceId: referenceId,
    );
    await _orderRepo.updateFinancialState(orderId, 'refunded');
  }

  /// Records loss (outflow). Call for non-collected, write-off, etc.
  Future<void> recordLoss(String? orderId, double amount, {String? referenceId}) async {
    await _ledger.append(
      type: LedgerEntryType.loss.name,
      amount: -amount,
      orderId: orderId,
      referenceId: referenceId,
    );
    if (orderId != null) {
      await _orderRepo.updateFinancialState(orderId, 'loss');
    }
  }

  /// Manual adjustment (e.g. initial capital, correction). Amount can be positive or negative.
  Future<void> recordAdjustment(double amount, {String? referenceId}) async {
    await _ledger.append(
      type: LedgerEntryType.adjustment.name,
      amount: amount,
      referenceId: referenceId,
    );
  }
}
