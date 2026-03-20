class MessageCategory {
  static const String info = 'INFO';
  static const String question = 'QUESTION';
  static const String complaint = 'COMPLAINT';
  static const String returnIntent = 'RETURN_INTENT';
  static const String escalation = 'ESCALATION';
}

class MessageAnalysis {
  const MessageAnalysis({
    required this.category,
    required this.confidence,
    required this.signals,
  });

  final String category;
  final double confidence; // 0..1
  final List<String> signals;
}

/// Deterministic-first analyzer for buyer/customer messages.
/// Fast, explainable regex+keyword rules (no ML).
class CustomerMessageAnalyzer {
  const CustomerMessageAnalyzer();

  MessageAnalysis analyze(String body) {
    final text = body.trim();
    final lower = text.toLowerCase();
    final signals = <String>[];

    bool hasAny(List<String> needles) {
      for (final n in needles) {
        if (lower.contains(n)) return true;
      }
      return false;
    }

    // Escalation / legal / chargeback style language
    if (hasAny([
      'chargeback',
      'bank',
      'refund now',
      'scam',
      'fraud',
      'police',
      'lawsuit',
      'allegro support',
      'claim',
      'dispute',
      'report',
    ])) {
      signals.add('escalationLanguage');
      return const MessageAnalysis(category: MessageCategory.escalation, confidence: 0.9, signals: ['escalationLanguage']);
    }

    // Return intent
    if (hasAny([
      'return',
      'refund',
      'send back',
      'want my money',
      'zwrot',
      'odstąpienie',
      'reklamacja',
      'nie chcę',
      'oddac',
      'oddaję',
    ])) {
      signals.add('returnIntent');
      return MessageAnalysis(category: MessageCategory.returnIntent, confidence: 0.85, signals: signals);
    }

    // Complaint signals
    if (hasAny([
      'broken',
      'damaged',
      'not working',
      'wrong item',
      'late',
      'delay',
      'missing',
      'bad quality',
      'zły',
      'uszkodz',
      'nie działa',
      'opóź',
      'brak',
      'pomyłka',
    ])) {
      signals.add('complaint');
      return MessageAnalysis(category: MessageCategory.complaint, confidence: 0.8, signals: signals);
    }

    // Question
    final isQuestion = lower.contains('?') ||
        hasAny(['when', 'where', 'how', 'what', 'czy', 'kiedy', 'gdzie', 'jak', 'co', 'dlaczego']);
    if (isQuestion) {
      signals.add('question');
      return MessageAnalysis(category: MessageCategory.question, confidence: 0.7, signals: signals);
    }

    // Default: info
    return const MessageAnalysis(category: MessageCategory.info, confidence: 0.6, signals: []);
  }
}

