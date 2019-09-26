/*预约不成功*/
import 'package:flutter/material.dart';

class FailurePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _FailurePage();
  }
}
class _FailurePage extends State<FailurePage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("预约不成功"),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}