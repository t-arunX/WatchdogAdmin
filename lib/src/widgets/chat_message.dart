import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../models/message.dart';
import '../constants/theme.dart';
import '../utils/code_element_builder.dart';

class ChatMessageWidget extends StatelessWidget {
  final Message message;

  const ChatMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == MessageSender.user;

    // Transparent background for 2024 UI style
    final backgroundColor = Colors.transparent;

    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Center(
        child: SizedBox(
          width: 768, // Max width for readability
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(isUser),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Padding(
                       padding: const EdgeInsets.only(top: 4.0),
                       child: isUser
                        ? Text(message.content, style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, height: 1.5))
                        : MarkdownBody(
                            data: message.content + (message.isStreaming ? " ●" : ""),
                            builders: {
                              'code': CodeElementBuilder(),
                            },
                            styleSheet: MarkdownStyleSheet(
                              p: const TextStyle(color: AppColors.textPrimary, fontSize: 16, height: 1.5),
                              strong: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                              h1: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 24),
                              h2: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 20),
                              // Code block decoration is now handled by the builder, but inline code needs style
                              code: const TextStyle(
                                backgroundColor: Colors.black26,
                                color: AppColors.textPrimary,
                                fontFamily: 'monospace',
                                fontSize: 14,
                              ),
                              blockquote: const TextStyle(color: AppColors.textSecondary),
                              blockquoteDecoration: const BoxDecoration(
                                border: Border(left: BorderSide(color: AppColors.textSecondary, width: 4)),
                              ),
                            ),
                            selectable: true,
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
          borderRadius: BorderRadius.circular(4),
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
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(4),
        child: const Icon(
          Icons.bolt,
          color: Colors.white,
          size: 18,
        ),
      );
    }
  }
}
