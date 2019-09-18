import 'package:json_annotation/json_annotation.dart'; 
  
part 'get_bank_card_response.g.dart';


@JsonSerializable()
  class GetBankCardResponse extends Object {

  @JsonKey(name: 'StatusCode')
  int statusCode;

  @JsonKey(name: 'Info')
  String info;

  @JsonKey(name: 'Data')
  List<Data> data;

  GetBankCardResponse(this.statusCode,this.info,this.data,);

  factory GetBankCardResponse.fromJson(Map<String, dynamic> srcJson) => _$GetBankCardResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GetBankCardResponseToJson(this);

}

  
@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'AccountPayID')
  int accountPayID;

  @JsonKey(name: 'UserID')
  String userID;

  @JsonKey(name: 'PayInfoCode')
  String payInfoCode;

  @JsonKey(name: 'PayInfoName')
  String payInfoName;

  @JsonKey(name: 'PayNo')
  String payNo;

  @JsonKey(name: 'IsUse')
  String isUse;

  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'limit')
  int limit;

  @JsonKey(name: 'Version')
  int version;

  @JsonKey(name: 'isSelect')
  bool isSelect ;

  Data(this.id,this.accountPayID,this.userID,this.payInfoCode,this.payInfoName,this.payNo,this.isUse,this.page,this.limit,this.version,this.isSelect);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
