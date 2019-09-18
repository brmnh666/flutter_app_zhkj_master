import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/bean/info_result.dart';
import 'package:flutter_app_zhkj_master/config/config.dart';
import 'package:flutter_app_zhkj_master/eventbus/global_eventbus.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/http/http_utils.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_app_zhkj_master/provider/sp_helper.dart';

class MyMeItemPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyMeItemPage();
  }
}

class _MyMeItemPage extends State<MyMeItemPage>{
  String _headurl="time.jpg"; //头像
  String _NickName="";//昵称
  String _phone="";//手机号

  @override
  void initState() {
    super.initState();
    SpHelper.getUserName().then((UserName)=> _getInfo(UserName));

    GlobalEventBus().eventBus.on<StateChangeEvent>().listen((event){
      if(event.state=="true"){//如果为true修改成功
        setState(() {
          SpHelper.getUserName().then((UserName)=> _getInfo(UserName));
        });
      }
    });

  }

  @override
  void dispose() {
    super.dispose();
    GlobalEventBus().eventBus.destroy();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromARGB(255,247,247,247),
      body:
          SingleChildScrollView( //调价滚动
            child:     Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 170,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.cyan,Colors.blue,Colors.blueAccent,Colors.blue,Colors.cyan]
                          )
                      ),
                      child: Row(
                        children: <Widget>[
                          /*头像显示*/
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child:ClipRRect(
                                borderRadius: BorderRadius.circular(35),
                                child:Image.network(
                                  Config.HEAD_URL+_headurl,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.fill, //图片填充方式
                                )
                            ),
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              /*店铺名*/
                              Padding(padding: EdgeInsets.only(left: 20,bottom: 8),child:  Text(_NickName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white))),
                              /*手机号*/
                              Padding(padding: EdgeInsets.only(left: 20),
                                child:Row(
                                  children: <Widget>[
                                    Image.asset(ImageHelper.wrapAssets("phone.png"),width: 13,height: 13),
                                    Text(_phone,style: TextStyle(fontSize: 13,color:Colors.white))
                                  ],
                                ),)
                            ],
                          )
                        ],
                      ),
                    ),

                    /*四个工单状态*/
                    Container(
                      margin: EdgeInsets.only(left: 5,right: 5,top: 125),
                      width: double.infinity,
                      height: 110,
                      child:
                      Card(
                        elevation: 2.0,
                        child:
                        Row(children: <Widget>[
                          /*已接待预约*/
                          Expanded(child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(ImageHelper.wrapAssets("icon_me_all_orders.png"),width: 30,height: 30),
                              Padding(padding: EdgeInsets.only(top: 10),
                                child: Text("已接待预约",style: TextStyle(fontSize: 12,color: Color.fromARGB(255,128,128,128))),
                              )
                            ],
                          ),
                            flex: 1,
                          ),

                          /*竖线*/
                          Container(
                            width: 1,
                            height: double.infinity,
                            margin: EdgeInsets.only(top: 10,bottom: 10),
                            color: Color.fromARGB(255,240,240,240),
                          ),

                          /*待返件*/

                          Expanded(
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(ImageHelper.wrapAssets("icon_me_return_sheet.png"),width: 30,height: 30),
                                Padding(padding: EdgeInsets.only(top: 10),
                                  child: Text("待返件",style: TextStyle(fontSize: 12,color: Color.fromARGB(255,128,128,128))),
                                )

                              ],
                            ),
                            flex: 1,
                          ),

                          /*竖线*/
                          Container(
                            width: 1,
                            height: double.infinity,
                            margin: EdgeInsets.only(top: 10,bottom: 10),
                            color: Color.fromARGB(255,240,240,240),
                          ),


                          /*质保单*/
                          Expanded(child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(ImageHelper.wrapAssets("icon_me_confirmed.png"),width: 30,height: 30),
                              Padding(padding: EdgeInsets.only(top: 10),
                                child: Text("质保单",style: TextStyle(fontSize: 12,color: Color.fromARGB(255,128,128,128))),
                              )
                            ],
                          ),
                            flex: 1,
                          ),

                          /*竖线*/
                          Container(
                            width: 1,
                            height: double.infinity,
                            margin: EdgeInsets.only(top: 10,bottom: 10),
                            color: Color.fromARGB(255,240,240,240),
                          ),


                          /*已完成*/
                          Expanded(child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(ImageHelper.wrapAssets("icon_me_finish.png"),width: 30,height: 30),
                              Padding(padding: EdgeInsets.only(top: 10),
                                child: Text("已完成",style: TextStyle(fontSize: 12,color: Color.fromARGB(255,128,128,128))),
                              )

                            ],
                          ),
                            flex: 1,
                          )

                        ],),
                      )
                      ,)


                  ],
                ),

                /*个人资料*/
                GestureDetector(child: Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 8),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child:
                    Row(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          child:Image.asset(ImageHelper.wrapAssets("personal.png"),width: 20,height: 20)),
                      Expanded(child: Text("个人资料",style: TextStyle(fontSize: 15))),
                      Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 20,height: 20))
                    ],
                    )
                ),
                onTap: (){
               //   Navigator.of(context).pushNamed("info");
                  NavigatorUtil.goInfoPage(context);
                },
                )
               ,

                /*我的钱包*/
                GestureDetector(
                  child:Container(
                      margin: EdgeInsets.only(left: 10,right: 10,top: 8),
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child:
                      Row(children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child:Image.asset(ImageHelper.wrapAssets("wallet.png"),width: 20,height: 20)),
                        Expanded(child: Text("我的钱包",style: TextStyle(fontSize: 15))),
                        Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 20,height: 20))
                      ],
                      )
                  ),
                  onTap: (){
                    NavigatorUtil.goMyWalletPage(context);
                  },
                ),


                /*子账号管理*/
                Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 1),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child:
                    Row(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          child:Image.asset(ImageHelper.wrapAssets("management.png"),width: 20,height: 20)),
                      Expanded(child: Text("子账号管理",style: TextStyle(fontSize: 15))),
                      Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 20,height: 20))
                    ],
                    )
                ),

                /*附属子账号管理*/
                Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 1),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child:
                    Row(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          child:Image.asset(ImageHelper.wrapAssets("management.png"),width: 20,height: 20)),
                      Expanded(child: Text("附属子账号管理",style: TextStyle(fontSize: 15))),
                      Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 20,height: 20))
                    ],
                    )
                ),

                /*分享给朋友成为师傅*/
                Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child:
                    Row(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          child:Image.asset(ImageHelper.wrapAssets("erweima.png"),width: 20,height: 20)),
                      Expanded(child: Text("分享给朋友成为师傅",style: TextStyle(fontSize: 15))),
                      Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 20,height: 20))
                    ],
                    )
                ),

                /*客服电话*/
                Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 1),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child:
                    Row(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          child:Image.asset(ImageHelper.wrapAssets("erweima.png"),width: 20,height: 20)),
                      Expanded(child: Text("客服电话",style: TextStyle(fontSize: 15))),
                      Text("400-6262-365"),
                      Padding(
                          padding: EdgeInsets.only(right: 15,left: 10),
                          child: Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 20,height: 20))
                    ],
                    )
                ),


                /*设置*/
                Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child:
                    Row(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          child:Image.asset(ImageHelper.wrapAssets("setting.png"),width: 20,height: 20)),
                      Expanded(child: Text("设置",style: TextStyle(fontSize: 15))),
                      Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 20,height: 20))
                    ],
                    )
                ),

                /*关于我们*/
                Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 1,bottom: 40),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child:
                    Row(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          child:Image.asset(ImageHelper.wrapAssets("setting.png"),width: 20,height: 20)),
                      Expanded(child: Text("关于我们",style: TextStyle(fontSize: 15))),
                      Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 20,height: 20))
                    ],
                    )
                ),





              ],

            ),

          )


    );
  }


  /*获取个人信息*/
  _getInfo(String UserID ,{String limit="1"}) async{
    var map=Map();
    map["UserID"]=UserID;
    map["limit"]=limit;
    await HttpUtils.post("Account/GetUserInfoList", map).then((data){
      var infoResult = InfoResult.fromJson(data);
      switch(infoResult.statusCode){
        case 200:
          setState(() {
            _headurl=infoResult.data.data[0].avator??"time.jpg";
            _NickName=infoResult.data.data[0].nickName??"暂无";
            _phone=infoResult.data.data[0].phone.replaceRange(3, 7, "****")??"暂无";

          });
          break;
      }
    });
  }

}