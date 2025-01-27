import 'package:flutter/material.dart';
import 'package:flutter_reminder/screens/SettingScreen.dart';

class HomeScreen extends StatefulWidget {
 
  final String title;
 
  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: Center(
        child: Text(widget.title),
      ),
    );
  }
}
