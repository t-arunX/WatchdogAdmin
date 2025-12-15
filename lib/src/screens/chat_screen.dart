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
        centerTitle: true,
        title: _buildModelSelector(),
        actions: [
           IconButton(onPressed: () {}, icon: const Icon(Icons.ios_share_outlined)),
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, chatProvider, child) {
                if (chatProvider.messages.isEmpty) {
                   return _buildEmptyState(context);
                }
                
                return ListView.builder(
                  // Attach to bottom if needed, but standard chat is top-down usually unless sticky bottom
                  // We'll stick to standard builder.
                  padding: const EdgeInsets.only(bottom: 20),
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
      ),
    );
  }

  Widget _buildModelSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.sidebarBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
           Text("GPT-4", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
           SizedBox(width: 4),
           Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textSecondary)
        ],
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
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white10,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.bolt, size: 40, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 20),
            Text(
               'How can I help you today?', 
               style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                 fontWeight: FontWeight.bold,
                 color: AppColors.textPrimary,
               )
            ),
            const SizedBox(height: 40),
            // Example prompts
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                   _buildSuggestionCard("Explain quantum computing", "in simple terms"),
                   _buildSuggestionCard("Got any creative ideas", "for a 10 year old's birthday?"),
                   _buildSuggestionCard("How do I make an HTTP request", "in Javascript?"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionCard(String title, String subtitle) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        ],
      ),
    );
  }
}
