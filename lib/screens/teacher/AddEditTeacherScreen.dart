import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/DatabaseHelper.dart';

class AddEditTeacherScreen extends StatefulWidget {
  final Map<String, dynamic>? teacher; // Receive teacher data

  AddEditTeacherScreen({this.teacher});

  @override
  _AddEditTeacherScreenState createState() => _AddEditTeacherScreenState();
}

class _AddEditTeacherScreenState extends State<AddEditTeacherScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = "", _phone = "", _email = "", _address = "";
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.teacher != null) {
      _isEditing = true;
      _name = widget.teacher!['name'];
      _phone = widget.teacher!['phone'];
      _email = widget.teacher!['email'];
      _address = widget.teacher!['address'];
      if (widget.teacher!['imagePath'] != null && widget.teacher!['imagePath'].isNotEmpty) {
        _image = File(widget.teacher!['imagePath']);
      }
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveTeacher() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final teacherData = {
        'name': _name,
        'phone': _phone,
        'email': _email,
        'address': _address,
        'imagePath': _image?.path ?? "",
      };

      if (_isEditing) {
        await DatabaseHelper().updateTeacher(widget.teacher!['id'], teacherData);
      } else {
        await DatabaseHelper().insertTeacher(teacherData);
      }

      Navigator.pop(context, true); // Return to teacher list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? "Edit Teacher" : "Add Teacher")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min, // Prevents unnecessary stretching
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null
                        ? FileImage(_image!) as ImageProvider
                        : AssetImage("assets/profile_placeholder.jpg"),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(Icons.camera_alt, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                buildTextField("Name", (value) => _name = value, initialValue: _name),
                buildTextField("Phone", (value) => _phone = value, initialValue: _phone, keyboardType: TextInputType.phone),
                buildTextField("Email", (value) => _email = value, initialValue: _email, keyboardType: TextInputType.emailAddress),
                buildTextField("Address", (value) => _address = value, initialValue: _address),
                SizedBox(height: 20),
                ElevatedButton(onPressed: _saveTeacher, child: Text("Save")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, Function(String) onSaved,
      {TextInputType keyboardType = TextInputType.text, String initialValue = ""}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
        keyboardType: keyboardType,
        initialValue: initialValue,
        validator: (value) => value!.isEmpty ? "Enter $label" : null,
        onSaved: (value) => onSaved(value!),
      ),
    );
  }
}
