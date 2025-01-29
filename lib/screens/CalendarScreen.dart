import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {

  final String title;

  const CalendarScreen({super.key, required this.title});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // Calendar controller
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Events map (key: date, value: list of events)
  final Map<DateTime, List<String>> _events = {};

  // Text controller for adding events
  final TextEditingController _eventController = TextEditingController();

  @override
  void dispose() {
    _eventController.dispose();
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
          // Calendar Widget
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: (day) => _events[day] ?? [],
          ),
          const SizedBox(height: 16),

          // Display Events for Selected Day
          Expanded(
            child: _selectedDay == null
                ? const Center(child: Text('Select a day to view events'))
                : ListView.builder(
              itemCount: _events[_selectedDay]?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_events[_selectedDay]![index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _events[_selectedDay]!.removeAt(index);
                        if (_events[_selectedDay]!.isEmpty) {
                          _events.remove(_selectedDay);
                        }
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
        onPressed: () => _showAddEventDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  // Dialog to add an event
  void _showAddEventDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Event'),
        content: TextField(
          controller: _eventController,
          decoration: const InputDecoration(hintText: 'Enter event name'),
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
              if (_eventController.text.isNotEmpty && _selectedDay != null) {
                setState(() {
                  if (_events[_selectedDay!] == null) {
                    _events[_selectedDay!] = [];
                  }
                  _events[_selectedDay!]!.add(_eventController.text);
                  _eventController.clear();
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
