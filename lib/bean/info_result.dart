import 'package:json_annotation/json_annotation.dart'; 
  
part 'info_result.g.dart';


@JsonSerializable()
  class InfoResult extends Object {

  @JsonKey(name: 'StatusCode')
  int statusCode;

  @JsonKey(name: 'Info')
  String info;

  @JsonKey(name: 'Data')
  Data data;

  InfoResult(this.statusCode,this.info,this.data,);

  factory InfoResult.fromJson(Map<String, dynamic> srcJson) => _$InfoResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InfoResultToJson(this);

}

  
@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'count')
  String count;

  @JsonKey(name: 'data')
  List<Data1> data;

  Data(this.code,this.msg,this.count,this.data,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
@JsonSerializable()
  class Data1 extends Object {

  @JsonKey(name: 'Id')
  String id;

  @JsonKey(name: 'UserID')
  String userID;

  @JsonKey(name: 'NickName')
  String nickName;

  @JsonKey(name: 'Avator')
  String avator;

  @JsonKey(name: 'CreateDate')
  String createDate;

  @JsonKey(name: 'LastLoginDate')
  String lastLoginDate;

  @JsonKey(name: 'LoginCount')
  int loginCount;

  @JsonKey(name: 'RemainMoney')
  double remainMoney;

  @JsonKey(name: 'TotalMoney')
  double totalMoney;

  @JsonKey(name: 'FrozenMoney')
  double frozenMoney;

  @JsonKey(name: 'Type')
  String type;

  @JsonKey(name: 'TopRank')
  String topRank;

  @JsonKey(name: 'IsUse')
  String isUse;

  @JsonKey(name: 'PassWord')
  String passWord;

  @JsonKey(name: 'PayPassWord')
  String payPassWord;

  @JsonKey(name: 'RoleID')
  int roleID;

  @JsonKey(name: 'RoleName')
  String roleName;

  @JsonKey(name: 'AccountID')
  int accountID;

  @JsonKey(name: 'DistrictCode')
  String districtCode;

  @JsonKey(name: 'Con')
  int con;

  @JsonKey(name: 'Longitude')
  String longitude;

  @JsonKey(name: 'Dimension')
  String dimension;

  @JsonKey(name: 'ProvinceCode')
  String provinceCode;

  @JsonKey(name: 'CityCode')
  String cityCode;

  @JsonKey(name: 'AreaCode')
  String areaCode;

  @JsonKey(name: 'Address')
  String address;

  @JsonKey(name: 'DepositMoney')
  double depositMoney;

  @JsonKey(name: 'DepositFrozenMoney')
  double depositFrozenMoney;

  @JsonKey(name: 'IfAuth')
  String ifAuth;

  @JsonKey(name: 'AuthMessage')
  String authMessage;

  @JsonKey(name: 'TrueName')
  String trueName;

  @JsonKey(name: 'IDCard')
  String iDCard;

  @JsonKey(name: 'Sex')
  String sex;

  @JsonKey(name: 'Phone')
  String phone;

  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'limit')
  int limit;

  @JsonKey(name: 'Version')
  int version;

  Data1(this.id,this.userID,this.nickName,this.avator,this.createDate,this.lastLoginDate,this.loginCount,this.remainMoney,this.totalMoney,this.frozenMoney,this.type,this.topRank,this.isUse,this.passWord,this.payPassWord,this.roleID,this.roleName,this.accountID,this.districtCode,this.con,this.longitude,this.dimension,this.provinceCode,this.cityCode,this.areaCode,this.address,this.depositMoney,this.depositFrozenMoney,this.ifAuth,this.authMessage,this.trueName,this.iDCard,this.sex,this.phone,this.page,this.limit,this.version,);

  factory Data1.fromJson(Map<String, dynamic> srcJson) => _$Data1FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Data1ToJson(this);

}

  
