/*待返件*/
import 'package:flutter/material.dart';

class StayBackPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _StayBackPage();
  }
}
class _StayBackPage extends State<StayBackPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("待返件"),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}