import 'package:json_annotation/json_annotation.dart'; 
  
part 'get_bill_response.g.dart';


@JsonSerializable()
  class GetBillResponse extends Object {

  @JsonKey(name: 'StatusCode')
  int statusCode;

  @JsonKey(name: 'Info')
  String info;

  @JsonKey(name: 'Data')
  Data data;

  GetBillResponse(this.statusCode,this.info,this.data,);

  factory GetBillResponse.fromJson(Map<String, dynamic> srcJson) => _$GetBillResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GetBillResponseToJson(this);

}

  
@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'Item1')
  bool item1;

  @JsonKey(name: 'Item2')
  Item2 item2;

  Data(this.item1,this.item2,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
@JsonSerializable()
  class Item2 extends Object {

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'count')
  String count;

  @JsonKey(name: 'data')
  List<Data2> data;

  Item2(this.code,this.msg,this.count,this.data,);

  factory Item2.fromJson(Map<String, dynamic> srcJson) => _$Item2FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Item2ToJson(this);

}

  
@JsonSerializable()
  class Data2 extends Object {

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'FinancialID')
  int financialID;

  @JsonKey(name: 'PayTypeCode')
  String payTypeCode;

  @JsonKey(name: 'PayTypeName')
  String payTypeName;

  @JsonKey(name: 'PayMoney')
  double payMoney;

  @JsonKey(name: 'CreateTime')
  String createTime;

  @JsonKey(name: 'State')
  String state;

  @JsonKey(name: 'StateName')
  String stateName;

  @JsonKey(name: 'IsInvoice')
  String isInvoice;

  @JsonKey(name: 'OrderID')
  int orderID;

  @JsonKey(name: 'IsUse')
  String isUse;

  @JsonKey(name: 'UserID')
  String userID;

  @JsonKey(name: 'ActualMoney')
  double actualMoney;

  @JsonKey(name: 'ShareMoney')
  double shareMoney;

  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'limit')
  int limit;

  @JsonKey(name: 'StateList')
  List<dynamic> stateList;

  @JsonKey(name: 'Version')
  int version;

  Data2(this.id,this.financialID,this.payTypeCode,this.payTypeName,this.payMoney,this.createTime,this.state,this.stateName,this.isInvoice,this.orderID,this.isUse,this.userID,this.actualMoney,this.shareMoney,this.page,this.limit,this.stateList,this.version,);

  factory Data2.fromJson(Map<String, dynamic> srcJson) => _$Data2FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Data2ToJson(this);

}

  
