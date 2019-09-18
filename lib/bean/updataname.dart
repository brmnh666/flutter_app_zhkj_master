import 'package:json_annotation/json_annotation.dart'; 
  
part 'updataname.g.dart';


@JsonSerializable()
  class Updataname extends Object {

  @JsonKey(name: 'StatusCode')
  int statusCode;

  @JsonKey(name: 'Info')
  String info;

  @JsonKey(name: 'Data')
  Data data;

  Updataname(this.statusCode,this.info,this.data,);

  factory Updataname.fromJson(Map<String, dynamic> srcJson) => _$UpdatanameFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UpdatanameToJson(this);

}

  
@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'Item1')
  bool item1;

  @JsonKey(name: 'Item2')
  String item2;

  Data(this.item1,this.item2,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
