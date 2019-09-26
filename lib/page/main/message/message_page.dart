import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_app_zhkj_master/provider/index.dart';
import 'package:flutter_app_zhkj_master/provider/model/ConfigModel.dart';
import 'package:flutter_app_zhkj_master/provider/theme_util.dart';
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
    return DefaultTabController(
          length: 2,
          child:Scaffold(
              appBar: AppBar(
                flexibleSpace:
                Store.connect<ConfigModel>(
                    builder: (context, ConfigModel snapshot, child) {
                      return  Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: ThemeUtil.setActionBar(snapshot.theme)
                            )
                        ),
                      );
                    }
                ),

                bottom: TabBar(
                  tabs: title,
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
          )
    );


  }
}