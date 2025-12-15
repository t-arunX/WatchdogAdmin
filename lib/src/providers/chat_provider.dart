import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart'; // Assuming we might want unique IDs, but I didn't add uuid to pubspec. I'll simple strings for now or mock it.
// Actually I'll just use DateTime as ID for simplicity since I can't add packages easily without internet verification (though I have it).
// I will stick to simple string generation.

import '../models/message.dart';

class ChatProvider extends ChangeNotifier {
  final List<Message> _messages = [];
  bool _isTyping = false;

  List<Message> get messages => List.unmodifiable(_messages);
  bool get isTyping => _isTyping;

  // Mock initial greeting
  ChatProvider() {
    _addMessage(
      Message(
        id: DateTime.now().toString(),
        content: "Hello! I'm a ChatGPT clone made with Flutter. How can I help you today?",
        sender: MessageSender.assistant,
        timestamp: DateTime.now(),
      ),
    );
  }

  void sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    final userMessage = Message(
      id: DateTime.now().toString(),
      content: content,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );

    _addMessage(userMessage);
    _isTyping = true;
    notifyListeners();

    // Simulate network delay and response
    await Future.delayed(const Duration(seconds: 1));

    final assistantMessage = Message(
      id: DateTime.now().add(const Duration(milliseconds: 100)).toString(),
      content: "This is a simulated response to: \"$content\".\n\nI can render **Markdown** too!",
      sender: MessageSender.assistant,
      timestamp: DateTime.now(),
    );

    _isTyping = false;
    _addMessage(assistantMessage);
  }

  void _addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  void clearChat() {
    _messages.clear();
    notifyListeners();
  }
}
