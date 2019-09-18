import 'package:json_annotation/json_annotation.dart'; 
  
part 'get_province_response.g.dart';


@JsonSerializable()
  class GetProvinceResponse extends Object {

  @JsonKey(name: 'StatusCode')
  int statusCode;

  @JsonKey(name: 'Info')
  String info;

  @JsonKey(name: 'Data')
  List<Data> data;

  GetProvinceResponse(this.statusCode,this.info,this.data,);

  factory GetProvinceResponse.fromJson(Map<String, dynamic> srcJson) => _$GetProvinceResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GetProvinceResponseToJson(this);

}

  
@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'Id')
  String id;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'IsUse')
  String isUse;

  @JsonKey(name: 'Version')
  int version;

  Data(this.id,this.code,this.name,this.isUse,this.version,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
