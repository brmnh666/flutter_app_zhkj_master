
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HttpUtils {
  static const BASE_URL="http://47.96.126.145:8001/api/";
  static const CONNECT_TIMEOUT=5000;
  static const RECEIVE_TIMEOUT=3000;
  static Dio dio;


  //生成Dio实例
   static Dio getInstance() {

     /*构建没有headers的dio*/
     if(dio==null){
      var options=BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
        contentType: ContentType.parse('application/x-www-form-urlencoded'),
        //headers: {"userName":userName,"adminToken":adminToken}
      );
      dio=new Dio(options);
    }


    return dio;
  }

  ///请求api
  static Future<Map> request(String url,{data,method}) async{
    data = data ?? {};
    method = method ?? "get";
    var dio = getInstance();

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    dio.options.headers={"userName":sharedPreferences.getString("userName"),
                       "adminToken":sharedPreferences.getString("adminToken")};

    var res;
   if(method=="get"){
     var response =await dio.get(url);
     res=response.data;
   }else if(method=="post"){
     var response=await dio.post(url,data: data);
     res=response.data;
   }
   print(res.toString());
   return res;
  }
   ///get
  static Future<Map> get(url,data)=>request(url,data:data);
  ///post
  static Future<Map> post(url,data)=>request(url,data: data,method: "post");




}