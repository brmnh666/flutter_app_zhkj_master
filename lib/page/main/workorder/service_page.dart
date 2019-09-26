/*服务中*/
import 'package:flutter/material.dart';

class ServicePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ServicePage();
  }
}

class _ServicePage extends State<ServicePage> with AutomaticKeepAliveClientMixin{
  @override
  void initState() {
    super.initState();
    print("绘制了服务中");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("服务中"),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}