import 'package:flutter/material.dart';

class GetIosMac extends StatefulWidget {
  const GetIosMac({super.key});

  @override
  State<GetIosMac> createState() => _GetIosMacState();
}

class _GetIosMacState extends State<GetIosMac> {
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
