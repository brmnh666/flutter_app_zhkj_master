import 'package:json_annotation/json_annotation.dart'; 
  
part 'get_area_response.g.dart';


@JsonSerializable()
  class GetAreaResponse extends Object {

  @JsonKey(name: 'StatusCode')
  int statusCode;

  @JsonKey(name: 'Info')
  String info;

  @JsonKey(name: 'Data')
  Data data;

  GetAreaResponse(this.statusCode,this.info,this.data,);

  factory GetAreaResponse.fromJson(Map<String, dynamic> srcJson) => _$GetAreaResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GetAreaResponseToJson(this);

}

  
@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'Item1')
  bool item1;

  @JsonKey(name: 'Item2')
  List<Item2> item2;

  Data(this.item1,this.item2,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
@JsonSerializable()
  class Item2 extends Object {

  @JsonKey(name: 'Id')
  String id;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'parentcode')
  String parentcode;

  @JsonKey(name: 'IsUse')
  String isUse;

  @JsonKey(name: 'Version')
  int version;

  Item2(this.id,this.code,this.name,this.parentcode,this.isUse,this.version,);

  factory Item2.fromJson(Map<String, dynamic> srcJson) => _$Item2FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Item2ToJson(this);

}

  
