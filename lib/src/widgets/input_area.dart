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
        color: AppColors.background, // Chat background flows into input area on mobile usually, but desktop has gradient.
        // We'll mimic the mobile/web responsive feel: Solid bg.
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
             Color(0x00343541), // Transparent fade start
             AppColors.background, // Solid at bottom
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
                borderRadius: BorderRadius.circular(16), // Rounded pill shape
                border: Border.all(color: Colors.transparent), // Could add focus border here
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
                      maxLines: 6,
                      minLines: 1,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _handleSend(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: _canSend ? AppColors.primaryAction : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_upward, size: 20, color: _canSend ? Colors.white : AppColors.textSecondary),
                        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                        padding: EdgeInsets.zero,
                        splashRadius: 20,
                        onPressed: _handleSend,
                        tooltip: "Send message",
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
