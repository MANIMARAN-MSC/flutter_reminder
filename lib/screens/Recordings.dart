import 'package:flutter/material.dart';
class Recordings extends StatefulWidget {
  const Recordings({super.key});

  @override
  State<Recordings> createState() => _RecordingsState();
}

class _RecordingsState extends State<Recordings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recrodings"),
      ),
      body: Center(
        child: Text("Recordings"),
      ),
    );
  }
}
