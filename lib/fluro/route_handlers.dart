
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/page/certification_page.dart';
import 'package:flutter_app_zhkj_master/page/login.dart';
import 'package:flutter_app_zhkj_master/page/main/me/info_manage/info_manage_page.dart';
import 'package:flutter_app_zhkj_master/page/main/me/info_manage/mod_password_page.dart';
import 'package:flutter_app_zhkj_master/page/main/me/info_manage/update_service_area.dart';
import 'package:flutter_app_zhkj_master/page/main/me/info_manage/update_shopname_Page.dart';
import 'package:flutter_app_zhkj_master/page/main/me/my_wallet/my_wallet_page.dart';
import 'package:flutter_app_zhkj_master/page/main/me/my_wallet/recharge_page.dart';
import 'package:flutter_app_zhkj_master/page/main/me/my_wallet/selectbank_page.dart';
import 'package:flutter_app_zhkj_master/page/main/me/my_wallet/withdraw_page.dart';
import 'package:flutter_app_zhkj_master/page/splash_page.dart';
import 'package:flutter_app_zhkj_master/page/web_page.dart';

import '../main.dart';

/// 跳转到首页Splash
var splashHandler=Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params){
    return SplashPage();
  }
);

//跳转到登录页面
var loginHandler =Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params){
      return MyLoginPage();
    }
);

/// 跳转到主页
var homeHandler=Handler(
  handlerFunc:(BuildContext context, Map<String, List<String>> params){
    return MyHomePage();
  }
);

/// 跳转到个人信息页面
var infoHandler=Handler(
    handlerFunc:(BuildContext context, Map<String, List<String>> params){
      return MyInfoManagePage();
    }
);

///查看大图(头像)
var headpicHandler=Handler(
    handlerFunc:(BuildContext context, Map<String, List<String>> params){
      return LookPic();
    }
);
/// 修改店铺名页面
var updatenameHandler=Handler(
    handlerFunc:(BuildContext context, Map<String, List<String>> params){
      return MyupdateShopname();
    }
);

///修改密码页面
var modpasswordHandler=Handler(
    handlerFunc:(BuildContext context, Map<String, List<String>> params){
      return MyModPassWordPage();
    }
);

///修改服务区域页面
var updateserviceareaHandler=Handler(
    handlerFunc:(BuildContext context, Map<String, List<String>> params){
      return MyUpdateServicePage();
    }
);

///我的钱包页面
var mywalletHandler=Handler(
    handlerFunc:(BuildContext context, Map<String, List<String>> params){
      return MyWalletPage();
    }
);

///实名认证页面
var certificationHandler=Handler(
    handlerFunc:(BuildContext context, Map<String, List<String>> params){
      return CertificationPage();
    }
);

///充值页面
var rechargeHandler=Handler(
    handlerFunc:(BuildContext context, Map<String, List<String>> params){
      return RechargePage();
    }
);


///提现页面
var withdrawHandler=Handler(
    handlerFunc:(BuildContext context, Map<String, List<String>> params){
      return WithdrawPage();
    }
);

///选择银行卡页面
var selectbankHandler=Handler(
     handlerFunc:(BuildContext context, Map<String, List<String>> params){
       String index=params["index"]?.first;
      return SelectBankPage(index:index);
    }
);

///跳去web页面
var webpageHandler=Handler(
    handlerFunc:(BuildContext context, Map<String, List<String>> params){
     // String url=params["url"]?.first;
     // String title=params["title"]?.first;
      return WebPage();
    }
);
