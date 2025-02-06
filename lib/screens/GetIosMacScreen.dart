import 'package:flutter/material.dart';

class GetIosMacScreen extends StatefulWidget {
  const GetIosMacScreen({super.key});

  @override
  State<GetIosMacScreen> createState() => _GetIosMacScreenState();
}

class _GetIosMacScreenState extends State<GetIosMacScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GetIosMac"),
      ),
      body: Center(
        child: Text("GetIosMac"),
      ),
    );
  }
}
