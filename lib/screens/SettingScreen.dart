import 'package:flutter/material.dart';
import 'package:flutter_reminder/services/UiProvider.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  final String title;

  const SettingScreen({super.key, required this.title});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return ListView(
            children: [
              // _buildHeader("Settings"),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Account"),
              ),
              ListTile(
                leading: Icon(Icons.cloud_sync),
                title: Text("Cloud Sync"),
              ),
              ListTile(
                leading: Icon(Icons.event),
                title: Text("Planners"),
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text("Notifications"),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text("Time Table and Calendar"),
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: Text("Terms"),
              ),
              ListTile(
                leading: Icon(Icons.beach_access),
                title: Text("Holidays"),
              ),
              ListTile(
                leading: Icon(Icons.backup),
                title: Text("Backup and Restore"),
              ),
              ListTile(
                leading: Icon(Icons.dark_mode),
                title: Text("Dark Theme"),
                trailing: Switch(
                  onChanged: (value) { notifier.changeTheme(); },
                  value: notifier.isDark,
                ),
              ),
              ListTile(
                leading: Icon(Icons.color_lens),
                title: Text("Look and Appearance"),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Advanced"),
              ),
              _buildHeader("Billing and Support"),
              ListTile(
                leading: Icon(Icons.star),
                title: Text("Premium"),
                subtitle: Text("Manage your subscriptions and payments"),
              ),
              ListTile(
                leading: Icon(Icons.web),
                title: Text("Web App"),
                subtitle: Text("Access your Cloud Sync data from your Mac, PC, and iOS Device"),
              ),
              ListTile(
                leading: Icon(Icons.rate_review),
                title: Text("Write a Review"),
                subtitle: Text("If you are enjoying School Planner, please leave a review on the Play Store"),
              ),
              ListTile(
                leading: Icon(Icons.contact_mail),
                title: Text("Contact Us"),
                subtitle: Text("If you need help or have some advice"),
              ),
              ListTile(
                leading: Icon(Icons.science),
                title: Text("Become a Tester"),
                subtitle: Text("Access to early builds to get new features faster"),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About"),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
