/*完成待取机*/
import 'package:flutter/material.dart';

class FinishWaitPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _FinishWaitPage();
  }
}

class _FinishWaitPage extends State<FinishWaitPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("完成代取机"),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}