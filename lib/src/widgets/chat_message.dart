import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../models/message.dart';
import '../constants/theme.dart';

class ChatMessageWidget extends StatelessWidget {
  final Message message;

  const ChatMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == MessageSender.user;
    final backgroundColor = isUser
        ? AppColors.userMessageBackground
        : AppColors.assistantMessageBackground;

    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatar(isUser),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MarkdownBody(
                  data: message.content,
                  styleSheet: MarkdownStyleSheet(
                    p: const TextStyle(color: AppColors.textPrimary, fontSize: 16, height: 1.5),
                    strong: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                    code: const TextStyle(
                      backgroundColor: Colors.black26,
                      color: AppColors.textPrimary,
                      fontFamily: 'monospace',
                    ),
                    codeblockDecoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  selectable: true,
                ),
              ],
            ),
          ),
          // Spacer for centering if needed, but standard ChatGPT is full width list items
        ],
      ),
    );
  }

  Widget _buildAvatar(bool isUser) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: isUser ? Colors.purple : AppColors.primaryAction,
        borderRadius: BorderRadius.circular(2), // ChatGPT avatars are slightly rounded squares
      ),
      child: Icon(
        isUser ? Icons.person : Icons.bolt, // Placeholder for GPT logo
        color: Colors.white,
        size: 18,
      ),
    );
  }
}
