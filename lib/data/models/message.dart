enum MessageDirection {
  incoming,
  outgoing,
  internal,
}

/// Lightweight message model for future messaging support.
class Message {
  const Message({
    required this.id,
    required this.threadId,
    required this.direction,
    this.authorLabel,
    required this.body,
    required this.createdAt,
  });

  final String id;
  final String threadId;
  final MessageDirection direction;
  final String? authorLabel;
  final String body;
  final DateTime createdAt;
}

