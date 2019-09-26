/*配件单*/
import 'package:flutter/material.dart';

class AccessoriesPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AccessoriesPage();
  }
}
class _AccessoriesPage extends State<AccessoriesPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("配件单"),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}