import 'dart:io';

import 'package:flutter/material.dart';
import '../../utils/DatabaseHelper.dart';
import 'AddEditTeacherScreen.dart';

class TeacherScreen extends StatefulWidget {
  @override
  _TeacherScreenState createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  List<Map<String, dynamic>> _teachers = [];

  @override
  void initState() {
    super.initState();
    _loadTeachers();
  }

  Future<void> _loadTeachers() async {
    List<Map<String, dynamic>> teachers = await DatabaseHelper().getTeachers();
    setState(() {
      _teachers = teachers;
    });
  }

  Future<void> _deleteTeacher(int id) async {
    await DatabaseHelper().deleteTeacher(id);
    _loadTeachers(); // Refresh list
  }

  void _navigateToAddEditTeacher({Map<String, dynamic>? teacher}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditTeacherScreen(teacher: teacher),
      ),
    );
    _loadTeachers(); // Reload teachers after returning
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Teachers")),
      body: _teachers.isEmpty
          ? Center(child: Text("No teachers added yet"))
          : ListView.builder(
        itemCount: _teachers.length,
        itemBuilder: (context, index) {
          var teacher = _teachers[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: teacher['imagePath'] != null && teacher['imagePath'].isNotEmpty
                  ? FileImage(File(teacher['imagePath']))
                  : AssetImage("assets/profile_placeholder.jpg") as ImageProvider,
            ),
            title: Text(teacher['name']),
            subtitle: Text(teacher['phone']),
            onTap: () => _navigateToAddEditTeacher(teacher: teacher),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteTeacher(teacher['id']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddEditTeacher(),
        child: Icon(Icons.add),
      ),
    );
  }
}
