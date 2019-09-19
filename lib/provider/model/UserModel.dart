
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter_app_zhkj_master/provider/object/UserInfo.dart';

class UserModel extends UserInfo with ChangeNotifier{
  UserInfo _userInfo =UserInfo();
  String get username =>_userInfo.UserName;
  String get userid =>_userInfo.UserID;
  String get nickname =>_userInfo.NickName;
  String get avator => _userInfo.Avator;
  String get remainmoney =>_userInfo.RemainMoney;
  String get totalmoney =>_userInfo.TotalMoney;
  String get frozenmoney =>_userInfo.FrozenMoney;
  String get con =>_userInfo.Con;
  String get ifauth => _userInfo.IfAuth;
  String get truename =>_userInfo.TrueName;
  String get idcard =>_userInfo.IDCard;
  String get sex =>_userInfo.Sex;
  String get phone =>_userInfo.Phone;

  /*初始化数据*/

  void initUserInfo(
      String username, String userid, String nickname,String avator,String remainmoney,
      String totalmoney,String frozenmoney, String con,String ifauth,String truename,
      String idcard, String sex,String phone
      ){
      _userInfo.UserName=username;
      _userInfo.UserID=userid;
      _userInfo.NickName=nickname;
      _userInfo.Avator=avator;
      _userInfo.RemainMoney=remainmoney;
      _userInfo.TotalMoney=totalmoney;
      _userInfo.FrozenMoney=frozenmoney;
      _userInfo.Con=con;
      _userInfo.IfAuth=ifauth;
      _userInfo.TrueName=truename;
      _userInfo.IDCard=idcard;
      _userInfo.Sex=sex;
      _userInfo.Phone=phone;
      notifyListeners();
     }

     /*更新实名状态*/
     void setIfAuth(String ifauth){
       _userInfo.IfAuth=ifauth;
       notifyListeners();
     }


   /*设置username*/
  void setUserName(username){
    _userInfo.UserName=username;
    notifyListeners();
  }

}