import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/DatabaseHelper.dart';


class CalendarScreen extends StatefulWidget {
  final String title;

  const CalendarScreen({super.key, required this.title});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // Calendar variables
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Events map
  final Map<DateTime, List<String>> _events = {};

  // SQLite helper
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Text controller
  final TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final now = DateTime.now();
    final events = await _dbHelper.getEvents(now.toIso8601String());
    setState(() {
      _events[now] = events.map((e) => e['event'] as String).toList();
    });
  }

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
          // Calendar widget
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) async {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              final formattedDate = selectedDay.toIso8601String();
              final events = await _dbHelper.getEvents(formattedDate);
              setState(() {
                _events[selectedDay] = events.map((e) => e['event'] as String).toList();
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

          // Display events
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
                    onPressed: () async {
                      final formattedDate = _selectedDay!.toIso8601String();
                      final eventList = await _dbHelper.getEvents(formattedDate);
                      if (eventList.isNotEmpty) {
                        await _dbHelper.deleteEvent(eventList[index]['id']);
                        setState(() {
                          _events[_selectedDay]!.removeAt(index);
                          if (_events[_selectedDay]!.isEmpty) {
                            _events.remove(_selectedDay);
                          }
                        });
                      }
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
        // onPressed: () => _showAddEventBottomSheet(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddEventBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Event',
              // style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _eventController,
              decoration: const InputDecoration(
                labelText: 'Event Name',
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
                  onPressed: () async {
                    if (_eventController.text.isNotEmpty && _selectedDay != null) {
                      final formattedDate = _selectedDay!.toIso8601String();
                      await _dbHelper.insertEvent(formattedDate, _eventController.text);
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
          ],
        ),
      ),
    );
  }

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
            onPressed: () async {
              if (_eventController.text.isNotEmpty && _selectedDay != null) {
                final formattedDate = _selectedDay!.toIso8601String();
                await _dbHelper.insertEvent(formattedDate, _eventController.text);
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
