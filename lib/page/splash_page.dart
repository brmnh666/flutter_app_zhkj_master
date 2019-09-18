
import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:rxdart/rxdart.dart';

class SplashPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashPage();
  }
}
class _SplashPage extends State<SplashPage>{

  @override
  void initState() {
   //2秒后跳到主页面
   Observable.timer(0, Duration(seconds: 2)).listen((_){
     NavigatorUtil.goLoginPage(context);
   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:
      Container(
        width: double.infinity,
        height: double.infinity,
        child:Image.asset(ImageHelper.wrapAssets("icon_splash.png"),
            fit: BoxFit.fill),)



    );
  }



}