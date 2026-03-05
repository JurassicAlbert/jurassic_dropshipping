/// Estimates delivery dates based on supplier offer shipping data and handling time.
class ShippingEstimator {
  ShippingEstimator({this.handlingDays = 1});

  /// Days the seller needs to process and hand off to carrier.
  final int handlingDays;

  /// Estimate the promised delivery window from order date.
  DeliveryEstimate estimate({
    required int? minCarrierDays,
    required int? maxCarrierDays,
    DateTime? orderDate,
  }) {
    final now = orderDate ?? DateTime.now();
    final minDays = handlingDays + (minCarrierDays ?? 7);
    final maxDays = handlingDays + (maxCarrierDays ?? 21);
    return DeliveryEstimate(
      minDays: minDays,
      maxDays: maxDays,
      earliestDelivery: now.add(Duration(days: minDays)),
      latestDelivery: now.add(Duration(days: maxDays)),
    );
  }
}

class DeliveryEstimate {
  const DeliveryEstimate({
    required this.minDays,
    required this.maxDays,
    required this.earliestDelivery,
    required this.latestDelivery,
  });
  final int minDays;
  final int maxDays;
  final DateTime earliestDelivery;
  final DateTime latestDelivery;
}
