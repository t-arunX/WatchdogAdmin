import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import '../widgets/chat_message.dart';
import '../widgets/input_area.dart';
import '../widgets/app_drawer.dart';
import '../constants/theme.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Chat'), // Dynamic title based on context
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, chatProvider, child) {
                if (chatProvider.messages.isEmpty) {
                   return Center(
                     child: Text(
                       'ChatGPT',
                       style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                         fontWeight: FontWeight.bold,
                         color: Colors.white24,
                       )
                     )
                   );
                }

                return ListView.builder(
                  itemCount: chatProvider.messages.length + (chatProvider.isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == chatProvider.messages.length) {
                       return const LinearProgressIndicator(
                         backgroundColor: AppColors.assistantMessageBackground,
                         color: AppColors.primaryAction,
                       ); // Simple typing indicator
                    }
                    return ChatMessageWidget(message: chatProvider.messages[index]);
                  },
                );
              },
            ),
          ),
          const InputArea(),
        ],
      ),
    );
  }
}
