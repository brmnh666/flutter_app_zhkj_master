import 'package:json_annotation/json_annotation.dart'; 
  
part 'get_work_response.g.dart';


@JsonSerializable()
  class GetWorkResponse extends Object {

  @JsonKey(name: 'StatusCode')
  int statusCode;

  @JsonKey(name: 'Info')
  String info;

  @JsonKey(name: 'Data')
  Data data;

  GetWorkResponse(this.statusCode,this.info,this.data,);

  factory GetWorkResponse.fromJson(Map<String, dynamic> srcJson) => _$GetWorkResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GetWorkResponseToJson(this);

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
  List<Data2> data;

  Data(this.code,this.msg,this.count,this.data,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
@JsonSerializable()
  class Data2 extends Object {

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'OrderID')
  int orderID;

  @JsonKey(name: 'TypeID')
  int typeID;

  @JsonKey(name: 'TypeName')
  String typeName;

  @JsonKey(name: 'SubTypeID')
  int subTypeID;

  @JsonKey(name: 'CategoryID')
  int categoryID;

  @JsonKey(name: 'CategoryName')
  String categoryName;

  @JsonKey(name: 'SubCategoryID')
  int subCategoryID;

  @JsonKey(name: 'SubCategoryName')
  String subCategoryName;

  @JsonKey(name: 'Memo')
  String memo;

  @JsonKey(name: 'BrandID')
  int brandID;

  @JsonKey(name: 'BrandName')
  String brandName;

  @JsonKey(name: 'Num')
  int num;

  @JsonKey(name: 'ProvinceCode')
  String provinceCode;

  @JsonKey(name: 'CityCode')
  String cityCode;

  @JsonKey(name: 'AreaCode')
  String areaCode;

  @JsonKey(name: 'DistrictCode')
  String districtCode;

  @JsonKey(name: 'Address')
  String address;

  @JsonKey(name: 'Longitude')
  String longitude;

  @JsonKey(name: 'Dimension')
  String dimension;

  @JsonKey(name: 'UserID')
  String userID;

  @JsonKey(name: 'Guarantee')
  String guarantee;

  @JsonKey(name: 'UserName')
  String userName;

  @JsonKey(name: 'Phone')
  String phone;

  @JsonKey(name: 'CreateDate')
  String createDate;

  @JsonKey(name: 'AudDate')
  String audDate;

  @JsonKey(name: 'State')
  String state;

  @JsonKey(name: 'StateHtml')
  String stateHtml;

  @JsonKey(name: 'Extra')
  String extra;

  @JsonKey(name: 'ExtraTime')
  String extraTime;

  @JsonKey(name: 'ExtraFee')
  double extraFee;

  @JsonKey(name: 'IsUse')
  String isUse;

  @JsonKey(name: 'SendUser')
  String sendUser;

  @JsonKey(name: 'LoginUser')
  String loginUser;

  @JsonKey(name: 'IsPay')
  String isPay;

  @JsonKey(name: 'OrderMoney')
  double orderMoney;

  @JsonKey(name: 'InitMoney')
  double initMoney;

  @JsonKey(name: 'BeyondMoney')
  double beyondMoney;

  @JsonKey(name: 'QuaMoney')
  double quaMoney;

  @JsonKey(name: 'BeyondID')
  int beyondID;

  @JsonKey(name: 'BeyondDistance')
  String beyondDistance;

  @JsonKey(name: 'AccessorySendState')
  String accessorySendState;

  @JsonKey(name: 'AccessoryMoney')
  double accessoryMoney;

  @JsonKey(name: 'AccessorySearchState')
  String accessorySearchState;

  @JsonKey(name: 'AccessoryServiceMoney')
  double accessoryServiceMoney;

  @JsonKey(name: 'ServiceMoney')
  double serviceMoney;

  @JsonKey(name: 'PostMoney')
  double postMoney;

  @JsonKey(name: 'ApplyNum')
  int applyNum;

  @JsonKey(name: 'QApplyNum')
  int qApplyNum;

  @JsonKey(name: 'MallID')
  int mallID;

  @JsonKey(name: 'Grade')
  int grade;

  @JsonKey(name: 'Grade1')
  int grade1;

  @JsonKey(name: 'Grade2')
  int grade2;

  @JsonKey(name: 'Grade3')
  int grade3;

  @JsonKey(name: 'UpdateTime')
  String updateTime;

  @JsonKey(name: 'LateTime')
  String lateTime;

  @JsonKey(name: 'RecycleOrderHour')
  int recycleOrderHour;

  @JsonKey(name: 'IsRecevieGoods')
  String isRecevieGoods;

  @JsonKey(name: 'Distance')
  double distance;

  @JsonKey(name: 'OrderImg')
  List<dynamic> orderImg;

  @JsonKey(name: 'ReturnaccessoryImg')
  List<dynamic> returnaccessoryImg;

  @JsonKey(name: 'OrderAccessroyDetail')
  List<dynamic> orderAccessroyDetail;

  @JsonKey(name: 'OrderServiceDetail')
  List<dynamic> orderServiceDetail;

  @JsonKey(name: 'OrderBeyondImg')
  List<dynamic> orderBeyondImg;

  @JsonKey(name: 'OrderComplaintDetail')
  List<dynamic> orderComplaintDetail;

  @JsonKey(name: 'OrderAppraiseDetail')
  List<dynamic> orderAppraiseDetail;

  @JsonKey(name: 'SendOrderList')
  List<SendOrderList> sendOrderList;

  @JsonKey(name: 'IsLook')
  String isLook;

  @JsonKey(name: 'FIsLook')
  String fIsLook;

  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'limit')
  int limit;

  @JsonKey(name: 'StateList')
  List<dynamic> stateList;

  @JsonKey(name: 'SettlementMoney')
  double settlementMoney;

  @JsonKey(name: 'SettlementTime')
  String settlementTime;

  @JsonKey(name: 'Version')
  int version;

  Data2(this.id,this.orderID,this.typeID,this.typeName,this.subTypeID,this.categoryID,this.categoryName,this.subCategoryID,this.subCategoryName,this.memo,this.brandID,this.brandName,this.num,this.provinceCode,this.cityCode,this.areaCode,this.districtCode,this.address,this.longitude,this.dimension,this.userID,this.guarantee,this.userName,this.phone,this.createDate,this.audDate,this.state,this.stateHtml,this.extra,this.extraTime,this.extraFee,this.isUse,this.sendUser,this.loginUser,this.isPay,this.orderMoney,this.initMoney,this.beyondMoney,this.quaMoney,this.beyondID,this.beyondDistance,this.accessorySendState,this.accessoryMoney,this.accessorySearchState,this.accessoryServiceMoney,this.serviceMoney,this.postMoney,this.applyNum,this.qApplyNum,this.mallID,this.grade,this.grade1,this.grade2,this.grade3,this.updateTime,this.lateTime,this.recycleOrderHour,this.isRecevieGoods,this.distance,this.orderImg,this.returnaccessoryImg,this.orderAccessroyDetail,this.orderServiceDetail,this.orderBeyondImg,this.orderComplaintDetail,this.orderAppraiseDetail,this.sendOrderList,this.isLook,this.fIsLook,this.page,this.limit,this.stateList,this.settlementMoney,this.settlementTime,this.version,);

  factory Data2.fromJson(Map<String, dynamic> srcJson) => _$Data2FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Data2ToJson(this);

}

  
@JsonSerializable()
  class SendOrderList extends Object {

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'SendID')
  int sendID;

  @JsonKey(name: 'CreateDate')
  String createDate;

  @JsonKey(name: 'UserID')
  String userID;

  @JsonKey(name: 'OrderID')
  int orderID;

  @JsonKey(name: 'State')
  String state;

  @JsonKey(name: 'LoginUser')
  String loginUser;

  @JsonKey(name: 'IsUse')
  String isUse;

  @JsonKey(name: 'CategoryID')
  int categoryID;

  @JsonKey(name: 'CategoryName')
  String categoryName;

  @JsonKey(name: 'SubTypeID')
  int subTypeID;

  @JsonKey(name: 'Memo')
  String memo;

  @JsonKey(name: 'BrandID')
  int brandID;

  @JsonKey(name: 'BrandName')
  String brandName;

  @JsonKey(name: 'ProvinceCode')
  String provinceCode;

  @JsonKey(name: 'CityCode')
  String cityCode;

  @JsonKey(name: 'AreaCode')
  String areaCode;

  @JsonKey(name: 'Address')
  String address;

  @JsonKey(name: 'Guarantee')
  String guarantee;

  @JsonKey(name: 'UserName')
  String userName;

  @JsonKey(name: 'Phone')
  String phone;

  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'limit')
  int limit;

  @JsonKey(name: 'Version')
  int version;

  SendOrderList(this.id,this.sendID,this.createDate,this.userID,this.orderID,this.state,this.loginUser,this.isUse,this.categoryID,this.categoryName,this.subTypeID,this.memo,this.brandID,this.brandName,this.provinceCode,this.cityCode,this.areaCode,this.address,this.guarantee,this.userName,this.phone,this.page,this.limit,this.version,);

  factory SendOrderList.fromJson(Map<String, dynamic> srcJson) => _$SendOrderListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SendOrderListToJson(this);

}

  
