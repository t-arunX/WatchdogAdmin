import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/glass_container.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('Appearance'),
          _buildFontSettings(context),
          const SizedBox(height: 20),
          _buildSectionTitle('Accessibility'),
          _buildAccessibilitySettings(context),
          const SizedBox(height: 20),
          _buildSectionTitle('System'),
          _buildSystemSettings(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, left: 4.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }

  Widget _buildFontSettings(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return GlassContainer(
      height: 160,
      borderRadius: 16,
      color: Colors.white.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Font Size'),
                Text('${(settings.fontSizeScale * 100).toInt()}%'),
              ],
            ),
            Slider(
              value: settings.fontSizeScale,
              min: 0.8,
              max: 1.4,
              divisions: 6,
              activeColor: const Color(0xFF6C63FF),
              onChanged: settings.setFontSizeScale,
            ),
            const Divider(color: Colors.white24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Font Family'),
                DropdownButton<String>(
                  value: settings.fontFamily,
                  dropdownColor: const Color(0xFF2D2D44),
                  underline: const SizedBox(),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                  items: ['Inter', 'Roboto', 'Open Sans']
                      .map((f) => DropdownMenuItem(
                            value: f,
                            child: Text(f, style: const TextStyle(color: Colors.white)),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) settings.setFontFamily(val);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccessibilitySettings(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return GlassContainer(
      height: 130, // Adjusted height to fit content
      borderRadius: 16,
      color: Colors.white.withOpacity(0.05),
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('High Contrast'),
            subtitle: Text(
              'Increase contrast for better visibility',
              style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5)),
            ),
            value: settings.highContrast,
            activeColor: const Color(0xFF00E676),
            onChanged: settings.toggleHighContrast,
          ),
          Divider(height: 1, color: Colors.white.withOpacity(0.1)),
          SwitchListTile(
            title: const Text('Reduce Motion'),
            subtitle: Text(
              'Minimize animations',
              style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5)),
            ),
            value: settings.reduceMotion,
            activeColor: const Color(0xFF00E676),
            onChanged: settings.toggleReduceMotion,
          ),
        ],
      ),
    );
  }

  Widget _buildSystemSettings(BuildContext context) {
    return GlassContainer(
      height: 70, // Height for a single list tile
      borderRadius: 16,
      color: Colors.white.withOpacity(0.05),
      child: Center(
        child: ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('Version'),
          trailing: Text(
            '1.0.0',
            style: TextStyle(color: Colors.white.withOpacity(0.5)),
          ),
        ),
      ),
    );
  }
}
