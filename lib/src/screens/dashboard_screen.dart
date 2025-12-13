import 'package:flutter/material.dart';
import '../widgets/glass_container.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overview',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  'Active Users',
                  '1,234',
                  Icons.people_outline,
                  const Color(0xFF00E676),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  context,
                  'System Load',
                  '45%',
                  Icons.memory,
                  const Color(0xFF6C63FF),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Recent Activity',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GlassContainer(
                    height: 70,
                    borderRadius: 12,
                    color: Colors.white.withOpacity(0.05),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                    child: Center(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.1),
                          child: Icon(
                            Icons.access_time,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        title: Text('User login attempt #${index + 1000}'),
                        subtitle: Text('2 minutes ago • 192.168.1.${index + 10}'),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return GlassContainer(
      height: 120,
      borderRadius: 20,
      color: color.withOpacity(0.1),
      border: Border.all(color: color.withOpacity(0.3)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color, size: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
