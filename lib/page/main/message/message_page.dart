import 'package:flutter/material.dart';


class MyMessageItemPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomeItemPage();
  }
}

class _MyHomeItemPage extends State<MyMessageItemPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text("消息"),
      ),
    );
  }
}