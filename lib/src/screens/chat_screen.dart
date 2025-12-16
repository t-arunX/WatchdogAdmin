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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: AppColors.textSecondary),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          children: [
            const Icon(Icons.terminal, color: AppColors.textSecondary, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "t-arunX/WatchdogAdminPanel", // Mimicking the screenshot
                style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
           IconButton(
             onPressed: () {},
             icon: const Icon(Icons.add, color: AppColors.primary),
             tooltip: 'New Chat',
           ),
           IconButton(
             onPressed: () {},
             icon: const Icon(Icons.settings_outlined, color: AppColors.textSecondary),
             tooltip: 'Settings',
           ),
           const SizedBox(width: 8),
           const CircleAvatar(
             radius: 12,
             backgroundColor: AppColors.userAvatarColor,
             child: Icon(Icons.person, size: 16, color: Colors.white),
           ),
           const SizedBox(width: 16),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.white.withOpacity(0.05), height: 1),
        ),
      ),
      drawer: const AppDrawer(),
      body: Builder(
        builder: (context) {
          return Column(
            children: [
              Expanded(
                child: Consumer<ChatProvider>(
                  builder: (context, chatProvider, child) {
                    if (chatProvider.messages.isEmpty) {
                       return _buildEmptyState(context);
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: 20, top: 20),
                      itemCount: chatProvider.messages.length,
                      itemBuilder: (context, index) {
                        return ChatMessageWidget(message: chatProvider.messages[index]);
                      },
                    );
                  },
                ),
              ),
              const InputArea(),
            ],
          );
        }
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: const Icon(Icons.smart_toy_outlined, size: 48, color: AppColors.primary),
            ),
            const SizedBox(height: 24),
            const Text(
               'Jules',
               style: TextStyle(
                 fontSize: 24,
                 fontWeight: FontWeight.bold,
                 color: AppColors.textPrimary,
               )
            ),
             const SizedBox(height: 8),
            const Text(
               'AI Engineering Assistant',
               style: TextStyle(
                 fontSize: 16,
                 color: AppColors.textSecondary,
               )
            ),
          ],
        ),
      ),
    );
  }
}
