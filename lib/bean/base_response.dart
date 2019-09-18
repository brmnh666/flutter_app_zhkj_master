import 'package:json_annotation/json_annotation.dart'; 
  
part 'base_response.g.dart';


@JsonSerializable()
  class BaseResponse extends Object{

  @JsonKey(name: 'StatusCode')
  int statusCode;

  @JsonKey(name: 'Info')
  String info;

  @JsonKey(name: 'Data')
  Data data;

  BaseResponse(this.statusCode,this.info,this.data,);

  factory BaseResponse.fromJson(Map<String, dynamic> srcJson) => _$BaseResponseFromJson(srcJson);

}

  
@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'Item1')
  bool item1;

  @JsonKey(name: 'Item2')
  String item2;

  Data(this.item1,this.item2,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

}

  
