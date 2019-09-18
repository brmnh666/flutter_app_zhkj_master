import 'package:json_annotation/json_annotation.dart'; 
  
part 'get_wechat_pay_response.g.dart';


@JsonSerializable()
  class GetWechatPayResponse extends Object {

  @JsonKey(name: 'StatusCode')
  int statusCode;

  @JsonKey(name: 'Info')
  String info;

  @JsonKey(name: 'Data')
  Data data;

  GetWechatPayResponse(this.statusCode,this.info,this.data,);

  factory GetWechatPayResponse.fromJson(Map<String, dynamic> srcJson) => _$GetWechatPayResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GetWechatPayResponseToJson(this);

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

  @JsonKey(name: 'appid')
  String appid;

  @JsonKey(name: 'noncestr')
  String noncestr;

  @JsonKey(name: 'out_trade_no')
  String outTradeNo;

  @JsonKey(name: 'package')
  String package;

  @JsonKey(name: 'partnerid')
  String partnerid;

  @JsonKey(name: 'prepayid')
  String prepayid;

  @JsonKey(name: 'sign')
  String sign;

  @JsonKey(name: 'timestamp')
  String timestamp;

  Item2(this.appid,this.noncestr,this.outTradeNo,this.package,this.partnerid,this.prepayid,this.sign,this.timestamp,);

  factory Item2.fromJson(Map<String, dynamic> srcJson) => _$Item2FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Item2ToJson(this);

}

  
