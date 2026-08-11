enum MessageType {
  user,
  assistant,
}

class ChatMessage {
  final String text;
  final MessageType type;
  final DateTime time;

  ChatMessage({
    required this.text,
    required this.type,
    required this.time,
  });
}