import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final String title;

  const DashboardScreen({super.key, required this.title});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Dummy list of events for demonstration
  final List<Map<String, String>> events = [
    {'title': 'Team Meeting', 'date': '2023-10-15 10:00 AM'},
    {'title': 'Project Deadline', 'date': '2023-10-20 11:59 PM'},
    {'title': 'Birthday Party', 'date': '2023-10-25 07:00 PM'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to the add event screen
              // You can implement this navigation as per your app's requirements
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(event['title']!),
                    subtitle: Text(event['date']!),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Remove the event from the list
                        setState(() {
                          events.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the add event screen
                // You can implement this navigation as per your app's requirements
              },
              child: const Text('Add New Event'),
            ),
          ),
        ],
      ),
    );
  }
}