
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'application.dart';
import 'routes.dart';

class NavigatorUtil{

  /// 返回
  static void goBack(BuildContext context) {
    /// 其实这边调用的是 Navigator.pop(context);
    Application.router.pop(context);
  }


  /// 带参数的返回
  static void goBackWithParams(BuildContext context, result) {
    Navigator.pop(context, result);
  }



  /// 跳转到登录界面
  static void goLoginPage(BuildContext context){
    /// Routes.home 路由地址
    /// replace：true 就是将 splash 页面给移除掉了，这点后退键的时候就不会再出现Splash页面
    Application.router.navigateTo(context, Routes.login,replace: true);

  }


  /// 跳转到主页面
  static void goMainPage(BuildContext context){
    /// Routes.home 路由地址
    /// replace：true 就是将 splash 页面给移除掉了，这点后退键的时候就不会再出现Splash页面
    Application.router.navigateTo(context, Routes.main,replace: true);
  }


  /// 跳转到个人信息页面
   static void goInfoPage(BuildContext context){
    /// Routes.home 路由地址
    /// replace：true 就是将 splash 页面给移除掉了，这点后退键的时候就不会再出现Splash页面
     ///  /// 框架自带的有 native，nativeModal，inFromLeft，inFromRight，inFromBottom，fadeIn，custom
    Application.router.navigateTo(context, Routes.info,replace: false,transition: TransitionType.inFromRight);
  }

  ///查看大图头像
  static void goHeadPicPage(BuildContext context){
    /// replace：true 就是将 splash 页面给移除掉了，这点后退键的时候就不会再出现Splash页面
    Application.router.navigateTo(context, Routes.headpic,replace: false);
  }

    /// 跳转到修改店铺名页面
   static void goUpDateNamePage(BuildContext context){
    /// replace：true 就是将 splash 页面给移除掉了，这点后退键的时候就不会再出现Splash页面
    Application.router.navigateTo(context, Routes.updatename,replace: false,transition: TransitionType.inFromRight);
  }

  /// 跳转到修改密码页面
  static void goModPassWordPage(BuildContext context){
    /// replace：true 就是将 splash 页面给移除掉了，这点后退键的时候就不会再出现Splash页面
    Application.router.navigateTo(context, Routes.modpassword,replace: false,transition: TransitionType.inFromRight);
  }

  /// 跳转到修改服务区域页面
  static void goUpdateServicePage(BuildContext context){
    /// replace：true 就是将 splash 页面给移除掉了，这点后退键的时候就不会再出现Splash页面
    Application.router.navigateTo(context, Routes.updateservicearea,replace: false,transition: TransitionType.inFromRight);
  }

  /// 跳转到我的钱包页面
  static void goMyWalletPage(BuildContext context){
    /// replace：true 就是将 splash 页面给移除掉了，这点后退键的时候就不会再出现Splash页面
    Application.router.navigateTo(context, Routes.mywallet,replace: false,transition: TransitionType.inFromRight);
  }

  /// 跳转到我的实名认证
  static void goCertificationPage(BuildContext context){
    /// replace：true 就是将 splash 页面给移除掉了，这点后退键的时候就不会再出现Splash页面
    Application.router.navigateTo(context, Routes.certification,replace: false,transition: TransitionType.inFromRight);
  }

    ///跳转到提现页面
  static void goWithdrawPage(BuildContext context){
    /// replace：true 就是将 splash 页面给移除掉了，这点后退键的时候就不会再出现Splash页面
    Application.router.navigateTo(context, Routes.withdraw,replace: false,transition: TransitionType.inFromRight);
  }

  ///跳转到提现时选择银行卡页面  带返回值 index 为当前选择的银行卡的位置
  static Future goSelectBankPage(BuildContext context,String index){
    return Application.router.navigateTo(
        context,
        Routes.selectbank+"?index=$index",
        replace: false,
        transition: TransitionType.inFromRight);
  }

  ///跳转到充值页面
  static void goRechargePage(BuildContext context){
    /// replace：true 就是将 splash 页面给移除掉了，这点后退键的时候就不会再出现Splash页面
    Application.router.navigateTo(context, Routes.recharge,replace: false,transition: TransitionType.inFromRight);
  }

  ///跳转到条款页面
  static void goWebPage(BuildContext context){
     Application.router.navigateTo(
        context,
        Routes.webpage,
        replace: false,
        transition: TransitionType.inFromRight);
  }

  ///我的银行卡
  static void goMyBankCardListPage(BuildContext context){
    Application.router.navigateTo(
        context,
        Routes.mycardlist,
        replace: false,
        transition: TransitionType.inFromRight);
  }

  ///添加银行卡
  static void goAddBankCardPage(BuildContext context){
    Application.router.navigateTo(
        context,
        Routes.addbankcard,
        replace: false,
        transition: TransitionType.inFromRight);
  }

  ///跳转到子账号
  static void goByPassAccountPage(BuildContext context){
    Application.router.navigateTo(
        context,
        Routes.bypassaccount,
        replace: false,
        transition: TransitionType.inFromRight);
  }

}