
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'route_handlers.dart';

class Routes{
  static String root="/";
  static String login="/login";
  static String main="/main";
  static String info="/info";
  static String headpic="/headpic";
  static String updatename="/updatename";
  static String modpassword="/modpassword";
  static String updateservicearea="/updateservicearea";
  static String mywallet="/mywallet";
  static String certification="/certification";
  static String withdraw="/withdraw";
  static String selectbank="/selectbank";
  static String webpage = "/webpage";
  static String recharge="/recharge";
  static String mycardlist="/mycardlist";
  static String addbankcard="/addbankcard";
  static String bypassaccount="/bypassaccount";

  static void configureRoutes(Router router){
    router.notFoundHandler=new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params){
        print("ROUTE WAS NOT FOUND !!!");
      }
    );

    /// 第一个参数是路由地址，第二个参数是页面跳转和传参，第三个参数是默认的转场动画，
    router.define(root, handler: splashHandler);
    router.define(login, handler: loginHandler);
    router.define(main, handler: homeHandler);
    router.define(info, handler: infoHandler);
    router.define(headpic, handler: headpicHandler);
    router.define(updatename, handler: updatenameHandler);
    router.define(modpassword, handler: modpasswordHandler);
    router.define(updateservicearea, handler: updateserviceareaHandler);
    router.define(mywallet, handler: mywalletHandler);
    router.define(certification, handler: certificationHandler);
    router.define(withdraw, handler: withdrawHandler);
    router.define(selectbank, handler: selectbankHandler);
    router.define(webpage, handler: webpageHandler);
    router.define(recharge, handler: rechargeHandler);
    router.define(mycardlist, handler: mycardlistHandler);
    router.define(addbankcard, handler: addbankcardHandler);
    router.define(bypassaccount, handler: bypassaccountHandler);
  }


}