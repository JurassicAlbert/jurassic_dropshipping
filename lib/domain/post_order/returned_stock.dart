/// Returned stock from customer/supplier (Phase 5). Used to fulfill from returned inventory.
class ReturnedStock {
  const ReturnedStock({
    required this.id,
    required this.productId,
    required this.supplierId,
    this.condition = 'as_new',
    required this.quantity,
    this.restockable = true,
    this.sourceOrderId,
    this.sourceReturnId,
    required this.createdAt,
  });

  final int id;
  final String productId;
  final String supplierId;
  final String condition;
  final int quantity;
  final bool restockable;
  final String? sourceOrderId;
  final String? sourceReturnId;
  final DateTime createdAt;
}
