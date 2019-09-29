import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';

class MessagePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MessagePage();
  }
}

class _MessagePage extends State<MessagePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255,240,240,240),
      body:Column(
        children: <Widget>[
          /*工单消息*/
          //0,191,150
          GestureDetector(
            child:   Container(
              height: 75,
              margin: EdgeInsets.only(top: 12,left: 10,right: 10,bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Row(children: <Widget>[
                Expanded(child:
                Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 0,191,150),
                            borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25,top: 5),
                        width: 25,
                        height: 35,
                        child: Image.asset(ImageHelper.wrapAssets("xiaoxi.png")),
                      )

                    ]
                ),
                  flex: 2,),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(bottom: 5),
                          child:Text("工单消息",style: TextStyle(fontSize: 16,color: Colors.black))),
                      Text("您最新的工单状态在这里展示....",style: TextStyle(fontSize: 12,color: Colors.grey),)
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child:
                  Container(
                    alignment: Alignment.center,
                    child: Center(
                     child: Container(
                       width: 12,
                       height:12 ,
                       decoration: BoxDecoration(
                         border: Border.all(width: 0.8,color: Colors.grey),
                         color: Colors.red,
                         borderRadius: BorderRadius.all(Radius.circular(6))
                       ),
                     ),
                   ),
                   // child: Text("+",style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w500),),
                  ),

                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 20,height: 20),
                  ),
                )
              ]
              ),
            ),
            onTap: (){
              NavigatorUtil.goMessageListPage(context);
            },
          ),

          /*交易信息*/
          //255,133,24
          GestureDetector(
            child:Container(
              height: 75,
              margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Row(children: <Widget>[
                Expanded(child:
                Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255,255,133,24),
                            borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25,top: 5),
                        width: 25,
                        height: 35,
                        child: Image.asset(ImageHelper.wrapAssets("jiaoyi.png")),
                      )

                    ]
                ),
                  flex: 2,),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(bottom: 5),
                          child:Text("交易信息",style: TextStyle(fontSize: 16,color: Colors.black))),
                      Text("交易、充值、提现、扣款等消息展示在这里......",style: TextStyle(fontSize: 12,color: Colors.grey),)
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child:
                  Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: Container(
                        width: 12,
                        height:12 ,
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.8,color: Colors.grey),
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(6))
                        ),
                      ),
                    ),

                  ),

                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 20,height: 20),
                  ),
                )
              ]
              ),
            ),
            onTap: (){
              NavigatorUtil.goTransactionListPage(context);
            },
          ),


          /*系统信息*/
          //255,79,22

          GestureDetector(
            child:  Container(
              height: 75,
              margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Row(children: <Widget>[
                Expanded(child:
                Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255,255,79,22),
                            borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 18,top: 6),
                        width: 40,
                        height: 35,
                        child: Image.asset(ImageHelper.wrapAssets("xitong.png")),
                      )

                    ]
                ),
                  flex: 2,),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(bottom: 5),
                          child:Text("系统消息",style: TextStyle(fontSize: 16,color: Colors.black))),
                      Text("系统推送的消息...",style: TextStyle(fontSize: 12,color: Colors.grey),)
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child:
                  Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: Container(
                        width: 12,
                        height:12 ,
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.8,color: Colors.grey),
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(6))
                        ),
                      ),
                    ),
                   // child: Text("o",style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w500),),
                  ),

                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 20,height: 20),
                  ),
                )

              ]
              ),
            ),
            onTap: (){
              /*CategoryID=7&page=1&limit=999    系统消息*/
              NavigatorUtil.goNotifucationPage(context,"7");
            },
          ),

        ],
      )
    );
  }

}