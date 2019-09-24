import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'message/my_message_page.dart';
import 'notification/notifucation_page.dart';


class MyMessageItemPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomeItemPage();
  }
}

class _MyHomeItemPage extends State<MyMessageItemPage>{
  List<Widget> title;
  List<Widget> pages;
  @override
  void initState() {
    super.initState();
    title=List()..add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(ImageHelper.wrapAssets("ic_xiaoxi.png"),width: 20,height: 20),
             Padding(padding:EdgeInsets.only(left: 3),
               child:Text("消息")),
          ],
        )
    )..add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(ImageHelper.wrapAssets("ic_tongzhi.png"),width: 20,height: 20),
            Padding(padding:EdgeInsets.only(left: 3),
                child:Text("通知")),
          ],
        ));
    pages= List()..add(MessagePage())..add(NotifucationPage());
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
          length: 2,
          child:Scaffold(
              appBar: AppBar(
                flexibleSpace:Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.cyan,Colors.blue,Colors.blueAccent,Colors.blue,Colors.cyan]
                      )
                  ),
                ) ,
                bottom: TabBar(tabs: title,
                  labelColor: Colors.white,
                  labelStyle: TextStyle(fontSize: 20),
                  labelPadding: EdgeInsets.only(bottom: 10),
                  isScrollable: false,
                  unselectedLabelColor: Colors.white,
                  indicatorColor: Colors.white,
                  indicatorWeight:2.5,
                  controller: DefaultTabController.of(context),
                ),
              ),
              body: TabBarView(
                children: pages,
              )
          ));


  }
}