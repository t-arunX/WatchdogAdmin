import 'package:flutter/material.dart';
import 'glass_container.dart';

class GlassBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const GlassBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GlassContainer(
          height: 80,
          borderRadius: 24,
          blur: 15,
          color: Theme.of(context).cardColor.withOpacity(0.6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(context, Icons.dashboard_rounded, 'Dashboard', 0),
              _buildNavItem(context, Icons.people_rounded, 'Users', 1),
              _buildNavItem(context, Icons.settings_rounded, 'Settings', 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, int index) {
    final isSelected = currentIndex == index;
    final color = isSelected ? Theme.of(context).colorScheme.secondary : Colors.grey;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
