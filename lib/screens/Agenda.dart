import 'package:flutter/material.dart';
class Agenda extends StatefulWidget {
  const Agenda({super.key});

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agenda"),
      ),
      body: Center(
        child: Text("Agenda"),
      ),
    );
  }
}
