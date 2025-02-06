import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TeachersScreen extends StatefulWidget {
  @override
  _TeachersScreenState createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _phone = "";
  String _email = "";
  String _address = "";
  File? _image; // Stores the selected image

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, // Change to ImageSource.camera for camera
      imageQuality: 80, // Adjust image quality
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Handle saving logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Profile Saved!")),
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              buildTextField("Name", (value) => _name = value),
              buildTextField("Phone", (value) => _phone = value, keyboardType: TextInputType.phone),
              buildTextField("Email", (value) => _email = value, keyboardType: TextInputType.emailAddress),
              buildTextField("Address", (value) => _address = value),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, Function(String) onSaved, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
        keyboardType: keyboardType,
        validator: (value) => value!.isEmpty ? "Enter $label" : null,
        onSaved: (value) => onSaved(value!),
      ),
    );
  }
}
