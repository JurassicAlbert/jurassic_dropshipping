import 'dart:convert';

/// Post-order incident type (Phase 3).
enum IncidentType {
  customerReturn14d,
  complaintDefect,
  parcelNotCollected,
  courierDamage,
  wrongItemSupplier,
  supplierOos,
  deliveryDelayed,
  customerClaimsDamagedAfterOpen,
  partialRefund,
  supplierRmaReturn,
  supplierWarehouseReturn,
  parcelAfterAwizo,
  courierDeliveredDamaged,
  itemMissingInParcel,
  damageClaim,
}

/// Incident record status.
enum IncidentStatus {
  open,
  supplierContacted,
  marketplaceContacted,
  resolved,
}

/// Domain model for incident record. Maps from [IncidentRecordRow].
class IncidentRecord {
  const IncidentRecord({
    required this.id,
    required this.orderId,
    required this.incidentType,
    required this.status,
    this.trigger = 'manual',
    this.automaticDecision,
    this.supplierInteraction,
    this.marketplaceInteraction,
    this.refundAmount,
    this.financialImpact,
    this.decisionLogId,
    required this.createdAt,
    this.resolvedAt,
    this.attachmentIds,
  });

  final int id;
  final String orderId;
  final IncidentType incidentType;
  final IncidentStatus status;
  final String trigger;
  final String? automaticDecision;
  final String? supplierInteraction;
  final String? marketplaceInteraction;
  final double? refundAmount;
  final double? financialImpact;
  final String? decisionLogId;
  final DateTime createdAt;
  final DateTime? resolvedAt;
  /// Attachment refs (e.g. photo IDs for damage claims). Phase 7.
  final List<String>? attachmentIds;

  static IncidentType typeFromString(String s) {
    final normalized = s.replaceAll(' ', '_').toLowerCase();
    return IncidentType.values.firstWhere(
      (e) => e.name == normalized,
      orElse: () => IncidentType.customerReturn14d,
    );
  }

  static String typeToString(IncidentType t) => t.name;

  static IncidentStatus statusFromString(String s) {
    return IncidentStatus.values.firstWhere(
      (e) => e.name == s,
      orElse: () => IncidentStatus.open,
    );
  }

  static String statusToString(IncidentStatus s) => s.name;

  static List<String>? attachmentIdsFromJson(String? json) {
    if (json == null || json.isEmpty) return null;
    try {
      final list = jsonDecode(json) as List<dynamic>?;
      return list?.map((e) => e.toString()).toList();
    } catch (_) {
      return null;
    }
  }

  static String? attachmentIdsToJson(List<String>? ids) {
    if (ids == null || ids.isEmpty) return null;
    return jsonEncode(ids);
  }
}
