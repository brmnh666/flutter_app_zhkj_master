import 'package:json_annotation/json_annotation.dart'; 
  
part 'get_sub_account_response.g.dart';


@JsonSerializable()
  class GetSubAccountResponse extends Object {

  @JsonKey(name: 'StatusCode')
  int statusCode;

  @JsonKey(name: 'Info')
  String info;

  @JsonKey(name: 'Data')
  List<Data> data;

  GetSubAccountResponse(this.statusCode,this.info,this.data,);

  factory GetSubAccountResponse.fromJson(Map<String, dynamic> srcJson) => _$GetSubAccountResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GetSubAccountResponseToJson(this);

}

  
@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'AccountID')
  int accountID;

  @JsonKey(name: 'UserID')
  String userID;

  @JsonKey(name: 'NickName')
  String nickName;

  @JsonKey(name: 'Avator')
  String avator;

  @JsonKey(name: 'PassWord')
  String passWord;

  @JsonKey(name: 'PayPassWord')
  String payPassWord;

  @JsonKey(name: 'CreateDate')
  String createDate;

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

  @JsonKey(name: 'ProvinceCode')
  String provinceCode;

  @JsonKey(name: 'CityCode')
  String cityCode;

  @JsonKey(name: 'AreaCode')
  String areaCode;

  @JsonKey(name: 'DistrictCode')
  String districtCode;

  @JsonKey(name: 'Longitude')
  String longitude;

  @JsonKey(name: 'Dimension')
  String dimension;

  @JsonKey(name: 'Address')
  String address;

  @JsonKey(name: 'DepositMoney')
  double depositMoney;

  @JsonKey(name: 'DepositFrozenMoney')
  double depositFrozenMoney;

  @JsonKey(name: 'ParentUserID')
  String parentUserID;

  @JsonKey(name: 'Distance')
  double distance;

  @JsonKey(name: 'ServiceStart')
  String serviceStart;

  @JsonKey(name: 'ServiceTotalMoney')
  double serviceTotalMoney;

  @JsonKey(name: 'ServiceTotalOrderNum')
  int serviceTotalOrderNum;

  @JsonKey(name: 'ServiceComplaintNum')
  int serviceComplaintNum;

  @JsonKey(name: 'Con')
  int con;

  @JsonKey(name: 'WaitMoney')
  double waitMoney;

  @JsonKey(name: 'ConDeposit')
  int conDeposit;

  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'limit')
  int limit;

  @JsonKey(name: 'Version')
  int version;

  Data(this.id,this.accountID,this.userID,this.nickName,this.avator,this.passWord,this.payPassWord,this.createDate,this.loginCount,this.remainMoney,this.totalMoney,this.frozenMoney,this.type,this.topRank,this.isUse,this.provinceCode,this.cityCode,this.areaCode,this.districtCode,this.longitude,this.dimension,this.address,this.depositMoney,this.depositFrozenMoney,this.parentUserID,this.distance,this.serviceStart,this.serviceTotalMoney,this.serviceTotalOrderNum,this.serviceComplaintNum,this.con,this.waitMoney,this.conDeposit,this.page,this.limit,this.version,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
