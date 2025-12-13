import 'package:flutter/material.dart';
import '../models/user.dart';
import '../widgets/glass_container.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'User Management',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              GlassContainer(
                width: 40,
                height: 40,
                borderRadius: 12,
                color: const Color(0xFF00E676).withOpacity(0.2),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Color(0xFF00E676)),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final user = User(
                  id: '$index',
                  name: 'User $index',
                  email: 'user$index@example.com',
                  role: index == 0 ? UserRole.admin : UserRole.editor,
                  isActive: index % 2 == 0,
                );

                return _buildUserCard(user);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(User user) {
    return GlassContainer(
      height: 90,
      borderRadius: 16,
      color: Colors.white.withOpacity(0.05),
      border: Border.all(color: Colors.white.withOpacity(0.1)),
      child: Center(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _getRoleColor(user.role).withOpacity(0.2),
            child: Text(
              user.name[0],
              style: TextStyle(color: _getRoleColor(user.role)),
            ),
          ),
          title: Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(user.email),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getRoleColor(user.role).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _getRoleColor(user.role).withOpacity(0.5)),
                ),
                child: Text(
                  user.roleName,
                  style: TextStyle(
                    color: _getRoleColor(user.role),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Icon(
                Icons.circle,
                size: 8,
                color: user.isActive ? Colors.green : Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getRoleColor(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return const Color(0xFF00E676);
      case UserRole.editor:
        return const Color(0xFF6C63FF);
      case UserRole.viewer:
        return Colors.grey;
    }
  }
}
