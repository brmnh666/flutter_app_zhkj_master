
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter_app_zhkj_master/provider/object/UserInfo.dart';

class UserModel extends UserInfo with ChangeNotifier{
  UserInfo _userInfo =UserInfo(UserName: "asafs");
  String get username =>_userInfo.UserName;

   /*设置username*/
  void setUserName(username){
    _userInfo.UserName=username;
    notifyListeners();
  }

}