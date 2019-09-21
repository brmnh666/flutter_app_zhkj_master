

import 'package:flutter/material.dart';

class ByPassAccountPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _ByPassAccountPage();
  }
}

class _ByPassAccountPage extends State<ByPassAccountPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,240,240,240),
      body: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.cyan,Colors.blue,Colors.blueAccent,Colors.blue,Colors.cyan]
            )
        ),

      ),

    );
  }

}