import 'package:flutter/material.dart';
import 'package:flutter_reminder/screens/DashbordScreen.dart';
import 'package:flutter_reminder/screens/SettingScreen.dart';

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
                } else if (items[index] == 'Messages') {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const MessageScreen(title: 'Message'),
                  //   ),
                  // );
                }
                else if (items[index] == 'People') {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const Peoplescreen(title: 'People'),
                  //   ),
                  // );
                }
                else if (items[index] == 'Battery') {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const Batteryscreen(title: 'Battery'),
                  //   ),
                  // );
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