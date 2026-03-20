import 'package:jurassic_dropshipping/services/messaging/customer_message_analyzer.dart';

class SuggestedReply {
  const SuggestedReply({
    required this.title,
    required this.body,
    required this.tone,
  });

  final String title;
  final String body;
  final String tone; // e.g. neutral, apologetic, firm
}

/// Phase 37: deterministic response engine (template-based).
class ResponseEngine {
  const ResponseEngine();

  SuggestedReply suggest({
    required MessageAnalysis analysis,
    required String buyerMessage,
  }) {
    switch (analysis.category) {
      case MessageCategory.returnIntent:
        return const SuggestedReply(
          title: 'Return / refund instructions',
          tone: 'apologetic',
          body:
              'Thank you for your message. I’m sorry for the inconvenience.\n\n'
              'To proceed with a return/refund, please confirm:\n'
              '1) The reason for return (optional)\n'
              '2) Whether the item is unused/used\n'
              '3) If you have photos (if damaged)\n\n'
              'Once confirmed, I will provide the return instructions and next steps.',
        );
      case MessageCategory.complaint:
        return const SuggestedReply(
          title: 'Complaint handling',
          tone: 'apologetic',
          body:
              'Thank you for letting us know — I’m sorry about the issue.\n\n'
              'To resolve this quickly, please share:\n'
              '- A short description of the problem\n'
              '- Photos (if damaged/wrong item)\n'
              '- Whether the package had visible damage\n\n'
              'After that, I will offer the fastest solution (replacement/refund).',
        );
      case MessageCategory.question:
        return const SuggestedReply(
          title: 'Clarification',
          tone: 'neutral',
          body:
              'Thanks for your question.\n\n'
              'Could you please clarify which detail you mean (delivery time, product specs, or order status)? '
              'Once I have that, I’ll answer right away.',
        );
      case MessageCategory.escalation:
        return const SuggestedReply(
          title: 'De-escalation',
          tone: 'firm',
          body:
              'I’m sorry for the frustration. I want to resolve this as quickly as possible.\n\n'
              'Please confirm your preferred resolution (refund or replacement) and provide any photos/details if relevant. '
              'I will handle it immediately.',
        );
      default:
        return const SuggestedReply(
          title: 'Acknowledgement',
          tone: 'neutral',
          body: 'Thank you for your message. I’m checking this now and will get back to you shortly.',
        );
    }
  }
}

