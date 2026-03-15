enum MessageThreadStatus {
  open,
  waitingForCustomer,
  resolved,
}

/// Lightweight message thread model (one per order per marketplace).
///
/// We intentionally avoid code generation here so that the app compiles
/// even before running build_runner. This model is used together with the
/// Drift `MessageThreads` table for future messaging features.
class MessageThread {
  const MessageThread({
    required this.id,
    required this.orderId,
    required this.targetPlatformId,
    this.marketplaceAccountId,
    this.externalThreadId,
    this.status = MessageThreadStatus.open,
    this.lastMessageAt,
    this.unreadCount = 0,
    required this.createdAt,
  });

  final String id;
  final String orderId;
  final String targetPlatformId;
  final String? marketplaceAccountId;
  final String? externalThreadId;
  final MessageThreadStatus status;
  final DateTime? lastMessageAt;
  final int unreadCount;
  final DateTime createdAt;
}

