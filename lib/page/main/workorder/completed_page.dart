/*已完成*/
import 'package:flutter/material.dart';

class CompletedPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CompletedPage();
  }
}

class _CompletedPage extends State<CompletedPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("已完成"),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}