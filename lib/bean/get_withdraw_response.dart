import 'package:json_annotation/json_annotation.dart'; 
  
part 'get_withdraw_response.g.dart';


@JsonSerializable()
  class GetWithdrawResponse extends Object {

  @JsonKey(name: 'StatusCode')
  int statusCode;

  @JsonKey(name: 'Info')
  String info;

  @JsonKey(name: 'Data')
  Data data;

  GetWithdrawResponse(this.statusCode,this.info,this.data,);

  factory GetWithdrawResponse.fromJson(Map<String, dynamic> srcJson) => _$GetWithdrawResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GetWithdrawResponseToJson(this);

}

  
@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'bzj')
  String bzj;

  @JsonKey(name: 'ktx')
  String ktx;

  @JsonKey(name: 'txz')
  String txz;

  @JsonKey(name: 'dqr')
  String dqr;

  @JsonKey(name: 'ljtx')
  String ljtx;

  Data(this.bzj,this.ktx,this.txz,this.dqr,this.ljtx,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
