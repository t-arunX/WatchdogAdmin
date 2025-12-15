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
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: OutlinedButton.icon(
                onPressed: () {
                  context.read<ChatProvider>().clearChat();
                  Navigator.pop(context); // Close drawer
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: const BorderSide(color: Colors.white24),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  minimumSize: const Size(double.infinity, 0),
                  alignment: Alignment.centerLeft,
                ),
                icon: const Icon(Icons.add),
                label: const Text('New Chat'),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildHistoryItem(context, "Flutter Cloning Plan"),
                _buildHistoryItem(context, "Dart Basics"),
                _buildHistoryItem(context, "State Management"),
              ],
            ),
          ),
          const Divider(color: Colors.white24),
          ListTile(
            leading: const Icon(Icons.person_outline, color: AppColors.textPrimary),
            title: const Text('Upgrade to Plus', style: TextStyle(color: AppColors.textPrimary)),
            onTap: () {},
          ),
           ListTile(
            leading: const Icon(Icons.settings, color: AppColors.textPrimary),
            title: const Text('Settings', style: TextStyle(color: AppColors.textPrimary)),
            onTap: () {},
          ),
        ],
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
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Icon(Icons.chat_bubble_outline, size: 18, color: AppColors.textSecondary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: AppColors.textPrimary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
