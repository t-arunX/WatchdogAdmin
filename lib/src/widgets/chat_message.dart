import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart';
import '../models/message.dart';
import '../constants/theme.dart';

class ChatMessageWidget extends StatelessWidget {
  final Message message;

  const ChatMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == MessageSender.user;

    // User messages transparent, Assistant slightly lighter
    final backgroundColor = isUser
        ? Colors.transparent
        : Colors.transparent; // ChatGPT 4 style often keeps assistant transparent too, or just clean separation.

    // We will follow the distinct look: Assistant messages in ChatGPT usually occupy full width but don't strictly have a bg color in the latest "Modern" design unless hovered, but historically they did.
    // Let's go with the classic "Dark Mode" look where assistant is slightly lighter or just separated by whitespace.
    // Actually, in the current 2024 UI, messages are just lists of text with icons.

    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Center(
        child: SizedBox(
          width: 768, // Max width for readability typically used by OpenAI on desktop
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(isUser),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     // Name label (Optional, sometimes seen in Group chats but usually not 1:1)
                     Padding(
                       padding: const EdgeInsets.only(top: 4.0), // Align with avatar
                       child: isUser
                        ? Text(message.content, style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, height: 1.5))
                        : MarkdownBody(
                            data: message.content + (message.isStreaming ? " ●" : ""), // Blinking cursor effect manually
                            styleSheet: MarkdownStyleSheet(
                              p: const TextStyle(color: AppColors.textPrimary, fontSize: 16, height: 1.5),
                              strong: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                              h1: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 24),
                              h2: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 20),
                              code: const TextStyle(
                                backgroundColor: Colors.black26,
                                color: AppColors.textPrimary,
                                fontFamily: 'monospace',
                                fontSize: 14,
                              ),
                              codeblockDecoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.white10),
                              ),
                              blockquote: const TextStyle(color: AppColors.textSecondary),
                              blockquoteDecoration: const BoxDecoration(
                                border: Border(left: BorderSide(color: AppColors.textSecondary, width: 4)),
                              ),
                            ),
                            selectable: true,
                            onTapText: () {},
                          ),
                     ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(bool isUser) {
    if (isUser) {
      return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: AppColors.userAvatarColor,
          borderRadius: BorderRadius.circular(4), // Slightly rounded
        ),
        alignment: Alignment.center,
        child: const Text("U", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
      );
    } else {
      return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: AppColors.gptAvatarColor,
          borderRadius: BorderRadius.circular(4), // ChatGPT logo is in a rounded square
        ),
        padding: const EdgeInsets.all(4),
        child: const Icon(
          Icons.bolt, // Best proxy for the logo without SVG asset
          color: Colors.white,
          size: 18,
        ),
      );
    }
  }
}
