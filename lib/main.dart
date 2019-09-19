import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_zhkj_master/provider/sp_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'bean/info_result.dart';
import 'eventbus/global_eventbus.dart';
import 'fluro/application.dart';
import 'fluro/routes.dart';
import 'http/http_utils.dart';
import 'manager/resource_mananger.dart';
import 'page/main/home/home_page.dart';
import 'page/main/me/me_page.dart';
import 'page/main/message/message_page.dart';
import 'page/main/shop/shop_page.dart';
import 'provider/index.dart';
import 'provider/model/UserModel.dart';


void main(){
  // 注册 fluro routes
  Router router =Router();
  Routes.configureRoutes(router);
  Application.router=router;
  runApp(MyApp());
  //透明状态栏
if(Platform.isAndroid){
  SystemUiOverlayStyle systemUiOverlayStyle=SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      /*Provider配置*/
      Store.init(
          context: context,
          //配置全局刷新样式
          child:RefreshConfiguration(
               hideFooterWhenNotFull: true, //未满屏禁止上拉加载
              child: MaterialApp(
            /*生成路由*/
            onGenerateRoute: Application.router.generator,
          ))
      );

  }
}



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    SpHelper.getUserName().then((username)=>
      _getInfo(username)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomBarPage(),
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
           /*初始化数据*/
           Store.value<UserModel>(context)
              .initUserInfo(
              infoResult.data.data[0].id,
              infoResult.data.data[0].userID,
              infoResult.data.data[0].nickName??"匿名用户",
              infoResult.data.data[0].avator??"time.jpg",
              infoResult.data.data[0].remainMoney.toString(),
              infoResult.data.data[0].totalMoney.toString(),
              infoResult.data.data[0].frozenMoney.toString(),
              infoResult.data.data[0].con.toString(),
              infoResult.data.data[0].ifAuth,
              infoResult.data.data[0].trueName??"未实名",
              infoResult.data.data[0].iDCard??"未实名",
              infoResult.data.data[0].sex??"未选择",
              infoResult.data.data[0].phone);


             print(Store.value<UserModel>(context).con);


          break;
      }
    });
  }



}

class BottomBarPage extends StatefulWidget{
  ////通过构造方法传值
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BottomBarPage();
  }
}

class _BottomBarPage extends State<BottomBarPage>{
  List<Widget> _pages;
  @override
  void initState(){
    super.initState();
    _pages=List()..add( MyHomeItemPage())..add(MyMessageItemPage())..add(MyShopItemPage())..add( MyMeItemPage());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildBottomTabScaffold();
  }

  //当前显示页面
  int currentIndex=0;

   //点击导航栏显示的页面

   final pages=[
     MyHomeItemPage(),
     MyMessageItemPage(),
     MyShopItemPage(),
     MyMeItemPage()
   ];

   Widget buildBottomTabScaffold(){
     return SizedBox(
       child: Scaffold(
         backgroundColor: Color.fromARGB(255,240,240,240),
         body: IndexedStack(
           index: currentIndex,
           children: _pages,
         ),
         //悬浮按钮位置
         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
         //悬浮按钮
         floatingActionButton: FloatingActionButton(
             child: Icon(Icons.add),
             onPressed: (){
               Fluttertoast.showToast(msg: "未开发");
             }),
         //其他菜单栏
         bottomNavigationBar: BottomAppBar(
           //悬浮按钮 与其他菜单的结合方式
           shape: CircularNotchedRectangle(),
           // FloatingActionButton和BottomAppBar 之间的差距
            notchMargin: 6.0,
            color: Colors.white,
            child: Row(
             mainAxisSize: MainAxisSize.max,
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: <Widget>[
               buildBottomItem(currentIndex,0,"icon_home","首页"),
               buildBottomItem(currentIndex,1,"icon_message","消息"),
               buildBottomItem(currentIndex,-1,null,"工单"),
               buildBottomItem(currentIndex,2,"icon_shop","配件商城"),
               buildBottomItem(currentIndex,3,"icon_me","我的")
             ],

           ),

         ),

       ),
     );
   }
  buildBottomItem(int selectIndex, int index, String iconData, String title) {
    Widget padItem = SizedBox();
    if(iconData!=null){
      //未选中状态的样式
      String Select = iconData+"_before.png";
      EdgeInsetsGeometry padding =  EdgeInsets.only(top: 8.0);
      TextStyle textStyle = TextStyle(fontSize: 12.0,color: Colors.grey);
      if(selectIndex==index){ //选中状态的文字样式
        Select=iconData+"_after.png";
        padding =  EdgeInsets.only(top:8.0);
        textStyle = TextStyle(fontSize: 12.0,color: Colors.blue);
      }
      padItem=Padding(
          padding: padding,
            child: Container(
            color: Colors.white,
               child: Center(
                 child: Column(
                  children: <Widget>[
                  /*  Icon(iconData,
                     color: iconColor,
                   size: iconSize,
                   ),*/
                  Image.asset(ImageHelper.wrapAssets(Select),width: 20,height: 20,),
                     Text(title,
                     style: textStyle
              )
            ],
          ),
        ),
      )
      );
    }

    Widget item=Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: (){
            if(index!=currentIndex){
              setState(() {
                currentIndex=index;
              });
            }
          },

          child: SizedBox(
            height: 52,
            child: padItem,
          ),

        ));
    return item;
   }

}







