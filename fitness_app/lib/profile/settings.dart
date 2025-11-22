import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static String routeName = 'settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1E),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        children: [
          _buildSettingItem(
            icon: Icons.person,
            label: 'Account',
            onTap: () {},
          ),
          _divider(),
          _buildSettingItem(
            icon: Icons.lock,
            label: 'Password',
            onTap: () {},
          ),
          _divider(),
          _buildSettingItem(
            icon: Icons.help_outline,
            label: 'Help',
            onTap: () {},
          ),
          _divider(),
          _buildSettingItem(
            icon: Icons.notifications_active_outlined,
            label: 'Notifications',
            onTap: () {},
          ),
          _divider(),
          _buildSettingItem(
            icon: Icons.feedback_outlined,
            label: 'Feedback',
            onTap: () {},
          ),
          _divider(),
          _buildSettingItem(
            icon: Icons.bug_report_outlined,
            label: 'Report Bugs',
            onTap: () {},
          ),
          _divider(),
          _buildSettingItem(
            icon: Icons.logout,
            label: 'Logout',
            onTap: () {},
            color: Colors.redAccent,
            isLogout: true,
          ),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(
    color: Color(0xFF2A2A2D),
    height: 1,
    thickness: 0.6,
  );

  Widget _buildSettingItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = Colors.orangeAccent,
    bool isLogout = false,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    color.withOpacity(0.25),
                    Colors.black.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 18),
            Text(
              label,
              style: TextStyle(
                color: isLogout ? Colors.redAccent : Colors.white,
                fontSize: 16,
                fontWeight:
                isLogout ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
