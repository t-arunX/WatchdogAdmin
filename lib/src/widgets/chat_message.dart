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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            _buildAvatar(isUser),
            const SizedBox(width: 12),
          ],

          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 768),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isUser ? AppColors.inputBackground : AppColors.cardBackground,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: isUser ? const Radius.circular(16) : const Radius.circular(4),
                  bottomRight: isUser ? const Radius.circular(4) : const Radius.circular(16),
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isUser)
                    Text(
                      message.content,
                      style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, height: 1.5),
                    )
                  else
                    MarkdownBody(
                      data: message.content + (message.isStreaming ? " ●" : ""),
                      builders: {
                        'code': CodeElementBuilder(),
                      },
                      styleSheet: MarkdownStyleSheet(
                        p: const TextStyle(color: AppColors.textPrimary, fontSize: 15, height: 1.5),
                        strong: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                        h1: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 22),
                        h2: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18),
                        h3: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16),
                        code: const TextStyle(
                          backgroundColor: Colors.transparent, // Handled by builder
                          color: AppColors.primary,
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
                          border: Border(left: BorderSide(color: AppColors.primary, width: 4)),
                        ),
                      ),
                      selectable: true,
                    ),
                ],
              ),
            ),
          ),

          if (isUser) ...[
            const SizedBox(width: 12),
            _buildAvatar(isUser),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatar(bool isUser) {
    if (isUser) {
      return Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: AppColors.userAvatarColor,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.person, size: 16, color: Colors.white),
      );
    } else {
      return Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: AppColors.julesAvatarColor,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.smart_toy, // Changed to a bot icon for Jules
          color: Colors.white,
          size: 18,
        ),
      );
    }
  }
}
