import 'package:flutter/material.dart';

import '../models/ClassSchedule.dart';

class ClassScheduleManagementScreen extends StatefulWidget {
  final String title;

  const ClassScheduleManagementScreen({super.key, required this.title});

  @override
  State<ClassScheduleManagementScreen> createState() =>
      _ClassScheduleManagementScreenState();
}

class _ClassScheduleManagementScreenState
    extends State<ClassScheduleManagementScreen> {
  // Timetable data
  final List<ClassSchedule> _schedules = [];

  // Controllers
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _teacherController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  // Selected day
  String _selectedDay = "Monday";

  @override
  void dispose() {
    _subjectController.dispose();
    _teacherController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _addClassDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows resizing with keyboard
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16, // Keyboard safe
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Class',
                // style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _teacherController,
                decoration: const InputDecoration(
                  labelText: 'Teacher',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _timeController,
                decoration: const InputDecoration(
                  labelText: 'Time',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_subjectController.text.isNotEmpty &&
                          _teacherController.text.isNotEmpty &&
                          _timeController.text.isNotEmpty) {
                        setState(() {
                          _schedules.add(
                            ClassSchedule(
                              subject: _subjectController.text,
                              teacher: _teacherController.text,
                              time: _timeController.text,
                              day: _selectedDay,
                            ),
                          );
                          _subjectController.clear();
                          _teacherController.clear();
                          _timeController.clear();
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<ClassSchedule> _getClassesForDay(String day) {
    return _schedules.where((schedule) => schedule.day == day).toList();
  }

  @override
  Widget build(BuildContext context) {
    final classesForSelectedDay = _getClassesForDay(_selectedDay);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // Day Selector
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final day in [
                  "Monday",
                  "Tuesday",
                  "Wednesday",
                  "Thursday",
                  "Friday"
                ])
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(day),
                      selected: _selectedDay == day,
                      onSelected: (selected) {
                        setState(() {
                          _selectedDay = day;
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Display Classes for the Selected Day
          Expanded(
            child: classesForSelectedDay.isEmpty
                ? const Center(child: Text('No classes scheduled.'))
                : ListView.builder(
              itemCount: classesForSelectedDay.length,
              itemBuilder: (context, index) {
                final schedule = classesForSelectedDay[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 4, horizontal: 8),
                  child: ListTile(
                    title: Text(schedule.subject),
                    subtitle:
                    Text('${schedule.teacher} • ${schedule.time}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _schedules.remove(schedule);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addClassDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
