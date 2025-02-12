import 'package:flutter/material.dart';
import 'package:flutter_reminder/Screens/CalendarScreen.dart';
import 'package:flutter_reminder/screens/AgendaScreen.dart';
import 'package:flutter_reminder/screens/AttendanceScreen.dart';
import 'package:flutter_reminder/screens/GetIosMacScreen.dart';
import 'package:flutter_reminder/screens/GradesScreen.dart';
import 'package:flutter_reminder/screens/HelpAndFeedbackScreen.dart';
import 'package:flutter_reminder/screens/OverViewScreen.dart';
import 'package:flutter_reminder/screens/RecordingsScreen.dart';
import 'package:flutter_reminder/screens/RemoveAdsScreen.dart';
import 'package:flutter_reminder/screens/SubjectScreen.dart';
import 'package:flutter_reminder/screens/TimeTableScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/SettingScreen.dart';
import '../screens/teacher/TeacherScreen.dart';

class CustomDrawer extends StatelessWidget {

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@example.com',  // The recipient's email address
      queryParameters: {
        'subject': 'I need help with the app',  // Default subject
        'body': 'Hello, I have a question or feedback.',  // Default body text
        'cc': 'cc@example.com',  // CC email (optional)
      },
      // query: 'subject=App Feedback&body=App Version 3.23',
    );

    try {
      if (await canLaunch(emailUri.toString())) {
        await launch(emailUri.toString());
      } else {
        print("Error: Could not open email client.");
      }
    } catch (e) {
      print('Error launching email client: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // DrawerHeader(
            //   decoration: BoxDecoration(
            //     color: Colors.blue,
            //   ),
            //   child: Text(
            //     'Menu',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 24,
            //     ),
            //   ),
            // ),
            _createDrawerItem(icon: Icons.dashboard, text: 'Overview', onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OverViewScreen(),
                ),
              );

            }),

            _createDrawerItem(icon: Icons.event, text: 'Agenda', onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AgendaScreen(),
                ),
              );

            }),

            _createDrawerItem(icon: Icons.calendar_today, text: 'Calendar', onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CalendarScreen(title: 'Calendar'),
                ),
              );

            }),

            _createDrawerItem(icon: Icons.schedule, text: 'Time Table', onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TimeTableScreen(),
                ),
              );

            }),

            Divider(),

            _createDrawerItem(icon: Icons.grade, text: 'Grades', onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GradesScreen(),
                ),
              );

            }),
            _createDrawerItem(icon: Icons.book, text: 'Subjects', onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SubjectScreen(),
                ),
              );

            }),

            _createDrawerItem(icon: Icons.check_circle, text: 'Attendance', onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AttendanceScreen(),
                ),
              );

            }),

            _createDrawerItem(icon: Icons.people, text: 'Teachers', onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TeacherScreen(),
                ),
              );

            }),
            _createDrawerItem(icon: Icons.videocam, text: 'Recordings', onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  RecordingsScreen(),
                ),
              );

            }),
            Divider(),
            _createDrawerItem(icon: Icons.remove_circle, text: 'Remove Ads', onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RemoveAdsScreen(),
                ),
              );

            }),
            _createDrawerItem(icon: Icons.apple, text: 'Get on iOS & Mac', onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GetIosMacScreen(),
                ),
              );

            }),
            _createDrawerItem(icon: Icons.help_outline, text: 'Help and Feedback', onTap: () {

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const HelpAndFeedbackScreen(),
              //   ),
              // );

              _launchEmail();

            }),
            _createDrawerItem(icon: Icons.settings, text: 'Settings', onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingScreen(title: 'Settings'),
                ),
              );

            }),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem({IconData? icon, required String text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Text(text),
      leading: Icon(icon),
      onTap: onTap,
    );
  }
}
