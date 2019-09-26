/*质保单*/
import 'package:flutter/material.dart';

class QualityPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _QualityPage();
  }
}

class _QualityPage extends State<QualityPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("质保单"),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}