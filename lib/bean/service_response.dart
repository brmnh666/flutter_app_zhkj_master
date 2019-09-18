import 'package:json_annotation/json_annotation.dart'; 
  
part 'service_response.g.dart';


@JsonSerializable()
  class ServiceResponse extends Object {

  @JsonKey(name: 'StatusCode')
  int statusCode;

  @JsonKey(name: 'Info')
  String info;

  @JsonKey(name: 'Data')
  List<Data> data;

  ServiceResponse(this.statusCode,this.info,this.data,);

  factory ServiceResponse.fromJson(Map<String, dynamic> srcJson) => _$ServiceResponseFromJson(srcJson);

}

  
@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'ServiceAreaID')
  int serviceAreaID;

  @JsonKey(name: 'UserID')
  String userID;

  @JsonKey(name: 'ProvinceCode')
  String provinceCode;

  @JsonKey(name: 'ProvinceName')
  String provinceName;

  @JsonKey(name: 'CityCode')
  String cityCode;

  @JsonKey(name: 'CityName')
  String cityName;

  @JsonKey(name: 'AreaCode')
  String areaCode;

  @JsonKey(name: 'AreaName')
  String areaName;

  @JsonKey(name: 'DistrictCode')
  String districtCode;

  @JsonKey(name: 'DistrictName')
  String districtName;

  @JsonKey(name: 'IsUse')
  String isUse;

  @JsonKey(name: 'Version')
  int version;

  Data(this.id,this.serviceAreaID,this.userID,this.provinceCode,this.provinceName,this.cityCode,this.cityName,this.areaCode,this.areaName,this.districtCode,this.districtName,this.isUse,this.version,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

}

  
