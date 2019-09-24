import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';

class NotifucationPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _NotifucationPage();
  }
}
class _NotifucationPage extends State<NotifucationPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,240,240,240),
      body: Column(children: <Widget>[

        GestureDetector(
          child:  Container(
            height: 60,
            margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            child: Row(
              children: <Widget>[
                Expanded(flex:1,child: Image.asset(ImageHelper.wrapAssets("comment.png"),width: 20,height: 20)),
                Expanded(flex:8,child: Text("平台政策",style: TextStyle(fontSize: 15,color: Colors.grey))),
                Expanded(flex:1,child: Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 15,height: 15)),
              ],
            ),
          ),
          onTap: (){
            /*CategoryID=7&page=1&limit=999   */
          NavigatorUtil.goNotifucationPage(context,"8");
          },
        ),

        GestureDetector(
          child: Container(
            height: 60,
            margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            child: Row(
              children: <Widget>[
                Expanded(flex:1,child: Image.asset(ImageHelper.wrapAssets("comment.png"),width: 20,height: 20)),
                Expanded(flex:8,child: Text("平台新闻",style: TextStyle(fontSize: 15,color: Colors.grey))),
                Expanded(flex:1,child: Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 15,height: 15)),
              ],
            ),
          ),
        onTap: (){
          NavigatorUtil.goNotifucationPage(context,"9");
        },
        ),

        GestureDetector(
          child:Container(
            height: 60,
            margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            child: Row(
              children: <Widget>[
                Expanded(flex:1,child: Image.asset(ImageHelper.wrapAssets("comment.png"),width: 20,height: 20)),
                Expanded(flex:8,child: Text("接单必读",style: TextStyle(fontSize: 15,color: Colors.grey))),
                Expanded(flex:1,child: Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 15,height: 15)),
              ],
            ),
          ),
        onTap: (){
          NavigatorUtil.goNotifucationPage(context,"10");
        },
        ),


      ],
      )
    );
  }
}