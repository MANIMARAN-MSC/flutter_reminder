import 'package:flutter/material.dart';
import 'package:flutter_reminder/screens/ClassScheduleManagementScreen.dart';
import 'package:flutter_reminder/screens/DashbordScreen.dart';
import 'package:flutter_reminder/screens/NotificationScreen.dart';
import 'package:flutter_reminder/screens/SettingScreen.dart';
import 'package:flutter_reminder/widgets/CustomDrawer.dart';

import 'CalendarScreen.dart';

class HomeScreen extends StatefulWidget {
 
  final String title;
 
  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<String> items = [
    'Dashboard',
    'Class Schedule Management',
    'Event Remainder',
    'Notifications',
    'Calendar',
    'Settings'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar:AppBar(
        title: Text(widget.title),
        actions: <Widget>[

          IconButton(
              onPressed:(){

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingScreen(title: 'Settings'),
                  ),
                );

              }

              , icon: Icon(Icons.settings)
          ),

        ],
      ) ,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {

                print(items[index]);
                if (items[index] == 'Dashboard') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardScreen(title: 'Dashboard'),
                    ),
                  );
                } else if (items[index] == 'Class Schedule Management') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ClassScheduleManagementScreen(title: 'Class Schedule Management'),
                    ),
                  );
                }
                else if (items[index] == 'Notifications') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationScreen(title: 'Notifications'),
                    ),
                  );
                }
                else if (items[index] == 'Calendar') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CalendarScreen(title: 'Event Reminder Calendar'),
                    ),
                  );
                }
                else if (items[index] == 'Settings') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingScreen(title: 'Settings'),
                    ),
                  );
                }


              },
              child: Card(
                color: Colors.blueAccent,
                child: Center(
                  child: Text(
                    items[index],
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}