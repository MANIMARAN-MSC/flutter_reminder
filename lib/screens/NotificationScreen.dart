import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  final String title;

  const NotificationScreen({super.key, required this.title});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // List of notifications
  final List<String> _notifications = [];

  // Text controller for adding notifications
  final TextEditingController _notificationController = TextEditingController();

  @override
  void dispose() {
    _notificationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),

          // Display Notifications List
          Expanded(
            child: _notifications.isEmpty
                ? const Center(child: Text('No notifications yet'))
                : ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_notifications[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _notifications.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNotificationDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  // Dialog to add a notification
  void _showAddNotificationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Notification'),
        content: TextField(
          controller: _notificationController,
          decoration: const InputDecoration(hintText: 'Enter notification text'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_notificationController.text.isNotEmpty) {
                setState(() {
                  _notifications.add(_notificationController.text);
                  _notificationController.clear();
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
