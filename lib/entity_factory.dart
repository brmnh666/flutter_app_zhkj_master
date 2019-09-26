import 'package:flutter_app_zhkj_master/bean/get_message_response_entity.dart';
import 'package:flutter_app_zhkj_master/bean/get_notifucation_response_entity.dart';
import 'package:flutter_app_zhkj_master/bean/get_sub_account_entity.dart';
import 'package:flutter_app_zhkj_master/bean/Loginentity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "GetMessageResponseEntity") {
      return GetMessageResponseEntity.fromJson(json) as T;
    } else if (T.toString() == "GetNotifucationResponseEntity") {
      return GetNotifucationResponseEntity.fromJson(json) as T;
    } else if (T.toString() == "GetSubAccountEntity") {
      return GetSubAccountEntity.fromJson(json) as T;
    } else if (T.toString() == "LoginResultEntity") {
      return LoginResultEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}