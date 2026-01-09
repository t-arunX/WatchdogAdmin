import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/message.dart';

class ChatProvider extends ChangeNotifier {
  final List<Message> _messages = [];
  bool _isTyping = false;

  List<Message> get messages => List.unmodifiable(_messages);
  bool get isTyping => _isTyping;

  void sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    // 1. Add User Message
    final userMessage = Message(
      id: DateTime.now().toString(),
      content: content,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );

    _addMessage(userMessage);
    _isTyping = true;
    notifyListeners();

    // 2. Prepare Assistant Response (Streaming)
    await Future.delayed(const Duration(milliseconds: 600)); // Network latency simulation

    final assistantMessage = Message(
      id: DateTime.now().add(const Duration(milliseconds: 100)).toString(),
      content: "", // Start empty
      sender: MessageSender.assistant,
      timestamp: DateTime.now(),
      isStreaming: true,
    );

    _addMessage(assistantMessage);

    // 3. Stream the response content
    final fullResponse = _generateMockResponse(content);

    // Simulate typing effect
    for (int i = 0; i < fullResponse.length; i++) {
      await Future.delayed(const Duration(milliseconds: 20)); // Typing speed

      // Fix: Update the specific assistantMessage object, NOT _messages.last
      // This prevents race conditions if the user sends another message while streaming.
      assistantMessage.content += fullResponse[i];
      notifyListeners();
    }

    assistantMessage.isStreaming = false;
    _isTyping = false;
    notifyListeners();
  }

  String _generateMockResponse(String input) {
    // A more elaborate mock response generator to show off markdown capabilities
    if (input.toLowerCase().contains("code") || input.toLowerCase().contains("flutter")) {
      return """Here is a simple example of a Counter app in Flutter:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Counter')),
        body: const Center(child: Text('0')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
```

This code sets up a basic `MaterialApp` with a `Scaffold`. Let me know if you need any adjustments!
""";
    }

    return "I am a simulated ChatGPT interface built with Flutter. You said: \"$input\".\n\nI can formatted text like **bold**, *italics*, and lists:\n\n1. First item\n2. Second item\n3. Third item\n\nIs there anything else I can help you with?";
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
