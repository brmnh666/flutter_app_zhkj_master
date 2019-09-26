import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_zhkj_master/bean/base_response.dart';
import 'package:flutter_app_zhkj_master/bean/get_sub_account_entity.dart'as sub;
import 'package:flutter_app_zhkj_master/config/config.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/http/http_utils.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_app_zhkj_master/provider/index.dart';
import 'package:flutter_app_zhkj_master/provider/model/ConfigModel.dart';
import 'package:flutter_app_zhkj_master/provider/sp_helper.dart';
import 'package:flutter_app_zhkj_master/provider/theme_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ByPassAccountPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ByPassAccountPage();
  }
}

class _ByPassAccountPage extends State<ByPassAccountPage>{
  List<sub.GetSubAccountData> list =List();
  int _point;//注销的位置

  @override
  void initState() {
    super.initState();
    SpHelper.getUserName().then((Username)=>_getchildrenaccount(Username));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,240,240,240),
      appBar:  AppBar(
        title: Text("子账号管理",
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
        //Container(
        //  decoration: BoxDecoration(
        //      gradient: LinearGradient(
        //          colors: [Colors.cyan,Colors.blue,Colors.blueAccent,Colors.blue,Colors.cyan]
        //      )
        //  ),
        //) ,
        elevation: 0,
      ),

      body: Stack(
        children: <Widget>[
          Store.connect<ConfigModel>(
              builder: (context, ConfigModel snapshot, child) {
                return  Container(
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: ThemeUtil.setActionBar(snapshot.theme)
                      )
                  ),
                  child:Column(
                    children: <Widget>[
                      GestureDetector(
                        child:Padding(padding: EdgeInsets.only(top: 10),
                          child:Image.asset(ImageHelper.wrapAssets("codeshare.png"),width: 37,height: 37),
                        ),
                        onTap: (){
                          /*弹出QR*/
                          SpHelper.getUserName().then((username){
                            showDialog<Null>(
                                context: context, //BuildContext对象
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return QRDialog( //调用对话框
                                    username: username,
                                  );
                                });
                          });

                        },
                      ),

                      Padding(padding: EdgeInsets.only(top: 8),
                          child:Text("点击二维码添加子账号",style: TextStyle(fontSize: 16,color: Colors.white))
                      ),

                    ],
                  ),
                );
              }
          ),

          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 100,left: 10,right: 10),
                child: ListView.builder(
                    itemCount: list.length==0?0:list.length,
                    itemBuilder: (context,index){
                      return index==_point?
                      Container(//注销
                        height: 160,
                        margin: EdgeInsets.only(bottom: 10),
                        child:
                          Column(
                            children: <Widget>[
                              Expanded(flex:2,
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(210, 103,58,183),
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(13),topRight:Radius.circular(13)),
                                  ),
                                  child: Text("是否注销尾号[${list[index].userID.substring(list[index].userID.length-4,list[index].userID.length)}]的账号",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.w500),))

                                ),
                              Expanded(flex: 1,
                              child: Row(children: <Widget>[
                                Expanded(flex: 1,
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(200,22,144,255),
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(13))
                                      ),
                                      child:
                                     GestureDetector(
                                       child:  Text("取消操作",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w500)),
                                      onTap: (){
                                       setState(() {
                                         _point=null;
                                       });
                                     },)
                                    )
                                ),
                                Expanded(flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(200, 244,67,54),
                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(13))
                                    ),
                                    child:
                                        GestureDetector(
                                          child:
                                          Text("确认注销",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w500)),
                                          onTap: (){
                                            SpHelper.getUserName().then((username)=>
                                                _cancelchildrenaccount(list[index].userID, username, index));
                                        },
                                        )



                                  ),
                                )
                              ],
                              ),
                              )
                            ],
                          )



                      /*


                      */
                      )
                      : Container(//未注销
                        margin: EdgeInsets.only(bottom: 10),
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(13))
                        ),
                        child: Column(
                          children: <Widget>[
                            /*第一行*/
                            Container(
                              height: 90,
                              child:  Row(children: <Widget>[
                                /*头像显示*/
                                Container(
                                  child:ClipRRect(
                                      borderRadius: BorderRadius.circular(35),
                                      child:Image.network(
                                        Config.HEAD_URL+"${list[index].avator}",
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.fill, //图片填充方式
                                      )
                                  ),
                                  margin: EdgeInsets.only(left: 10,top: 10),
                                ),
                                /*姓名*/
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                        list[index].ifAuth!="1"?
                                        "未实名认证":
                                         "${list[index].trueName}"
                                        ,style: TextStyle(color: Color.fromARGB(255,62,139,253),fontSize: 18,fontWeight: FontWeight.w500))
                                ),
                                /*注销账号*/
                                Expanded(
                                    child:
                                    GestureDetector(
                                      child: Container(
                                        alignment: Alignment.topRight,
                                        margin: EdgeInsets.only(right: 10,top: 20),
                                        child: Row(
                                          children: <Widget>[
                                            Text("注销账号",style: TextStyle(fontSize: 12,color: Color.fromARGB(255, 80,80,80))),
                                            Padding(padding: EdgeInsets.only(left: 5),
                                              child: Image.asset(ImageHelper.wrapAssets("logout.png"),width: 16,height: 16),)
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.end,
                                        ),
                                      ),onTap: (){
                                       setState(() {
                                         _point=index;
                                       });
                                    }),

                                )
                              ]
                              ),
                            ),

                            /*第二行*/
                            Container(
                              height: 70,
                              decoration:BoxDecoration(
                                color: Color.fromARGB(255,246,246,254),
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(13),bottomRight:Radius.circular(13))
                              ),
                              child: Row(
                                  children: <Widget>[
                                /*完成金额*/
                                Expanded(flex:1,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                    Text("${list[index].serviceTotalMoney}",style: TextStyle(color: Color.fromARGB(255, 193,94,253),fontSize: 12)),
                                    Text("完成金额",style: TextStyle(color: Color.fromARGB(255, 80,80,80),fontSize: 12))
                                  ]
                                  )
                                  ),

                                Container(
                                  width: 0.2,
                                  height: 70,
                                  margin: EdgeInsets.only(top: 15,bottom: 15),
                                  color: Colors.grey,
                                ),

                                /*完成数量*/
                                Expanded(flex:1,
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("${list[index].serviceTotalOrderNum}",style: TextStyle(color: Color.fromARGB(255,62,139,253))),
                                          Text("完成数量",style: TextStyle(color: Color.fromARGB(255, 80,80,80),fontSize: 12))
                                    ]
                                    )
                                ),
                                    Container(
                                      width: 0.2,
                                      height: 70,
                                      margin: EdgeInsets.only(top: 15,bottom: 15),
                                      color: Colors.grey,
                                    ),

                                /*被投诉*/
                                Expanded(flex:1,
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                      Text("${list[index].serviceComplaintNum}",style: TextStyle(color: Color.fromARGB(255,62,139,253))),
                                      Text("被投诉",style: TextStyle(color: Color.fromARGB(255, 80,80,80),fontSize: 12))
                                    ]
                                    )
                                )

                              ]),
                            )

                          ],
                        ),

                      );
            })
          )

        ],
      )


    );
  }

  /*s*/



  /*
  获取子账号
  http://47.96.126.145:8001/api/Account/GetChildAccountByParentUserID
  */
  _getchildrenaccount(String ParentUserID) async{
    var data=Map();
    data["ParentUserID"]=ParentUserID;
    await HttpUtils.post("Account/GetChildAccountByParentUserID", data).then((result){
      var getSubAccountEntity = sub.GetSubAccountEntity.fromJson(result);
      switch(getSubAccountEntity.statusCode){
        case 200:
          if(getSubAccountEntity.data.length!=0){
            setState(() {
              list=getSubAccountEntity.data;
            });
          }
          break;
      }

  });
  }

/*
  注销子账号
  "Account/CancelChildAccount"
  */
_cancelchildrenaccount(String UserID,String ParentUserID,int position)async{
  var data=Map();
  data["UserID"]=UserID;
  data["ParentUserID"]=ParentUserID;
  await HttpUtils.post("Account/CancelChildAccount", data).then((result){
    var baseResponse = BaseResponse.fromJson(result);
    switch(baseResponse.statusCode){
      case 200:
        if(baseResponse.data.item1&&baseResponse.data.item2=="注销成功"){
          Fluttertoast.showToast(msg: "注销成功");
          setState(() {
            list.removeAt(position);
          });
        }
        break;
    }
  });
}



}



class QRDialog extends Dialog {
  String username;
  QRDialog({Key key, @required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
        GestureDetector(
          child: Material( //创建透明层
          type: MaterialType.transparency, //透明类型
            child: Container(
              width: double.infinity,
              height: double.infinity,
            ),
        ),
        onTap: (){
            NavigatorUtil.goBack(context);
        },
        ),
        GestureDetector(child: Center( //保证控件居中效果
          child:  SizedBox(
            width: 250.0,
            height: 250.0,
            child:  Container(
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              child:
                QrImage(
                  data: "http://admin.xigyu.com/regchildaccount?ParentUserID=${username}&roleType=7",
                )
            ),
          ),
        ),
        onTap: (){
        },)

      ]
      );




  }
}