import 'package:flutter/material.dart';
class HelpAndFeedback extends StatefulWidget {
  const HelpAndFeedback({super.key});

  @override
  State<HelpAndFeedback> createState() => _HelpAndFeedbackState();
}

class _HelpAndFeedbackState extends State<HelpAndFeedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help and Feedback"),
      ),
      body: Center(
        child: Text("Help and Feedback"),
      ),
    );
  }
}
