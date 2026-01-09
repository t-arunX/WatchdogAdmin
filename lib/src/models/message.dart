enum MessageSender { user, assistant }

class Message {
  final String id;
  String content; // Mutable to allow streaming updates
  final MessageSender sender;
  final DateTime timestamp;
  bool isStreaming;

  Message({
    required this.id,
    required this.content,
    required this.sender,
    required this.timestamp,
    this.isStreaming = false,
  });
}
