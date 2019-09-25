import 'package:flutter/foundation.dart';
import 'package:flutter_app_zhkj_master/provider/object/ConfigInfo.dart';

class ConfigModel extends ConfigInfo with ChangeNotifier{
  ConfigInfo _configInfo =ConfigInfo();

  String get theme=>_configInfo.Theme;
/*初始化主题*/
  void initTheme(String theme){
    _configInfo.Theme=theme;
    notifyListeners();
  }

  /*更改主题*/
  void changeTheme(String theme){
    if(_configInfo.Theme!=theme){
      _configInfo.Theme=theme;
      notifyListeners();
    }

  }

}