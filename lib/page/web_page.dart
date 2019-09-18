import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPage extends StatefulWidget{
  //final String url;
  //final String title;
  //WebPage({this.url,this.title});

  @override
  State<StatefulWidget> createState() {
    return _WebPage();
  }
}

class _WebPage extends State<WebPage>{
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: "https://admin.xigyu.com/Agreement",
      appBar:  AppBar(
        title: Text("充值协议",
          style:TextStyle(
              fontSize: 15,
              color: Colors.white
          ),
        ),
        centerTitle: true,
        leading: IconButton(icon: Image.asset(
          ImageHelper.wrapAssets("icon_actionbar_return.png"),
          width: 20,
          height: 20,
        ), onPressed: (){
          NavigatorUtil.goBack(context);
        }
        ),
        flexibleSpace:Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.cyan,Colors.blue,Colors.blueAccent,Colors.blue,Colors.cyan]
              )
          ),
        ) ,
      ),
    );
  }

}