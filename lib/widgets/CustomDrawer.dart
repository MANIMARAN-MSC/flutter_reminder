import 'package:flutter/material.dart';

import '../screens/SettingScreen.dart';

class CustomDrawer extends StatelessWidget {
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
            _createDrawerItem(icon: Icons.dashboard, text: 'Overview', onTap: () {}),
            _createDrawerItem(icon: Icons.event, text: 'Agenda', onTap: () {}),
            _createDrawerItem(icon: Icons.calendar_today, text: 'Calendar', onTap: () {}),
            _createDrawerItem(icon: Icons.schedule, text: 'Time Table', onTap: () {}),
            Divider(),
            _createDrawerItem(icon: Icons.grade, text: 'Grades', onTap: () {}),
            _createDrawerItem(icon: Icons.book, text: 'Subjects', onTap: () {}),
            _createDrawerItem(icon: Icons.check_circle, text: 'Attendance', onTap: () {}),
            _createDrawerItem(icon: Icons.people, text: 'Teachers', onTap: () {}),
            _createDrawerItem(icon: Icons.videocam, text: 'Recordings', onTap: () {}),
            Divider(),
            _createDrawerItem(icon: Icons.remove_circle, text: 'Remove Ads', onTap: () {}),
            _createDrawerItem(icon: Icons.apple, text: 'Get on iOS & Mac', onTap: () {}),
            _createDrawerItem(icon: Icons.help_outline, text: 'Help and Feedback', onTap: () {}),
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
