import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import '../constants/theme.dart';

class InputArea extends StatefulWidget {
  const InputArea({super.key});

  @override
  State<InputArea> createState() => _InputAreaState();
}

class _InputAreaState extends State<InputArea> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _canSend = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _canSend = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (!_canSend) return;
    context.read<ChatProvider>().sendMessage(_controller.text);
    _controller.clear();
    _focusNode.requestFocus(); // Keep focus
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
             Color(0x00343541),
             AppColors.background,
          ],
          stops: [0.0, 0.2],
        )
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 10),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // The Input Pill
            Container(
              decoration: BoxDecoration(
                color: AppColors.inputBackground,
                borderRadius: BorderRadius.circular(26), // More rounded like modern GPT
                border: Border.all(color: Colors.transparent),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Attachment Icon
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, bottom: 10.0), // Align with single line text
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.transparent, // Or slight background
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, color: AppColors.textSecondary, size: 24),
                    ),
                  ),

                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, height: 1.5),
                      decoration: const InputDecoration(
                        hintText: 'Message ChatGPT...',
                        hintStyle: TextStyle(color: Colors.white38),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        isDense: true,
                      ),
                      // Dynamic Inputs configuration:
                      maxLines: 8, // Grows up to 8 lines
                      minLines: 1, // Starts at 1
                      textInputAction: TextInputAction.newline, // Allow newlines easily
                      keyboardType: TextInputType.multiline,
                      // We handle send manually or via specific key logic if desktop,
                      // but for mobile usually 'enter' is newline.
                      // If we want enter to send on desktop, we need RawKeyboardListener,
                      // but let's stick to mobile-first dynamic input behavior.
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: _canSend ? AppColors.textPrimary : Colors.transparent, // White bg when active (modern style)
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(4), // Padding inside the button container
                      child: InkWell(
                         onTap: _canSend ? _handleSend : null,
                         child: Icon(
                           Icons.arrow_upward,
                           size: 20,
                           color: _canSend ? AppColors.inputBackground : AppColors.textSecondary // Icon becomes dark on white bg
                         ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // The Disclaimer
            const Text(
              'ChatGPT can make mistakes. Consider checking important information.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textDiscreet,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
