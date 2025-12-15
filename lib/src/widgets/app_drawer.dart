import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import '../constants/theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.sidebarBackground,
      child: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: _buildNewChatButton(context),
            ),
          ),
          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                 const Padding(
                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                   child: Text("Today", style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
                 ),
                _buildHistoryItem(context, "Flutter Cloning Plan"),
                _buildHistoryItem(context, "Dart Basics"),
                _buildHistoryItem(context, "State Management Pattern"),
                 
                 const SizedBox(height: 16),
                 const Padding(
                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                   child: Text("Yesterday", style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
                 ),
                 _buildHistoryItem(context, "Recipe for Pizza"),
                 _buildHistoryItem(context, "Why is the sky blue?"),
              ],
            ),
          ),
          
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.white10)),
            ),
            child: Column(
              children: [
                _buildMenuItem(Icons.person_outline, "Upgrade to Plus"),
                _buildMenuItem(Icons.settings, "Settings"),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.userAvatarColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.center,
                      child: const Text("U", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                       child: Text("User Name", style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
                    ),
                    const Icon(Icons.more_horiz, color: AppColors.textSecondary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12), // Bottom safe area margin
        ],
      ),
    );
  }

  Widget _buildNewChatButton(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ChatProvider>().clearChat();
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Row(
          children: [
            Icon(Icons.add, color: AppColors.textPrimary, size: 18),
            SizedBox(width: 12),
            Text('New chat', style: TextStyle(color: AppColors.textPrimary, fontSize: 14)),
            Spacer(),
            Icon(Icons.edit_note, color: AppColors.textSecondary, size: 18), // New chat icon alternate
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(BuildContext context, String title) {
    return InkWell(
      onTap: () {
        // Load history logic
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12.0),
        child: Row(
          children: [
            const Icon(Icons.chat_bubble_outline, size: 16, color: AppColors.textSecondary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, size: 18, color: AppColors.textPrimary),
            const SizedBox(width: 12),
            Text(title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
