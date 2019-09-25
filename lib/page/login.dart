
import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/bean/base_response.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/http/http_utils.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_app_zhkj_master/provider/index.dart';
import 'package:flutter_app_zhkj_master/provider/model/ConfigModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyLoginPage();
  }
}
class _MyLoginPage extends State<MyLoginPage>{
  TextEditingController controller_username=TextEditingController();
  TextEditingController controller_password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child:Image.asset(
                ImageHelper.wrapAssets("app.png"),
                width: 80,
                height: 80,
                fit: BoxFit.fill, //图片填充方式
              )
          ),
           /*输入手机号*/
          Container(
            margin: EdgeInsets.only(top:30,left: 10,right: 10,bottom: 5),
            child:   TextField(
              //控制器 可以获取内容
              controller: controller_username,
              // controller: controller, //给TextField设置装饰（形状等）
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      color: Colors.black12),
                ),
                //输入内容距离上下左右的距离 ，可通过这个属性来控制 TextField的高度
                contentPadding: EdgeInsets.only(top: 10,bottom: 10,left: 10),
                hintText: "请输入手机号",
              ),
              ///光标设置
              cursorColor: Colors.black,
              cursorWidth: 2,
              cursorRadius: Radius.circular(1),
              //键盘类型设置
              keyboardType: TextInputType.number,
              //是否是密码
              obscureText: false,
            ),
          ),



        /*密码*/
        Container(
          margin: EdgeInsets.only(left: 10,right: 10,top: 5),
          child:   TextField(
            //控制器 可以获取内容
            controller: controller_password,
            // controller: controller, //给TextField设置装饰（形状等）
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                    color: Colors.black12),
              ),
              //输入内容距离上下左右的距离 ，可通过这个属性来控制 TextField的高度
              contentPadding: EdgeInsets.only(top: 10,bottom: 10,left: 10),
              hintText: "请输入密码",
            ),
            ///光标设置
            cursorColor: Colors.black,
            cursorWidth: 2,
            cursorRadius: Radius.circular(1),
            //键盘类型设置
            keyboardType: TextInputType.text,
            //是否是密码
            obscureText: true,
          ),
        ),

          /*登录*/
          GestureDetector(
            child: Container(
              child:Center(child:Text("登录",style: TextStyle(fontSize: 19,color: Colors.white))),
              padding: EdgeInsets.only(top: 13,bottom: 12),
              width: double.infinity,
              margin: EdgeInsets.only(left: 10,right: 10,top: 10),
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
            ),
            onTap: ()
            {
              if(controller_username.text==null||controller_username.text==""){
                Fluttertoast.showToast(msg: "请输入手机号");
                return;
              }

              if(controller_password.text==null||controller_password.text==""){
                Fluttertoast.showToast(msg: "请输入密码");
                return;
              }
              /*登陆*/
              _Login(controller_username.text,controller_password.text);

            },
          )



        ],
      )

    );
  }

  /*
  *
  * {"StatusCode":200,"Info":"请求(或处理)成功","Data":{"Item1":true,"Item2":"88f4ea28-115a-4d1f-8c22-2bb515d5a099"}}
  * */
  _Login(String userName, String passWord)async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var map=Map();
    map["userName"]=userName;
    map["passWord"]=passWord;
    map["RoleType"]="7";
   await HttpUtils.post("Account/LoginOn", map).then((data)  {
     var baseResponse = BaseResponse.fromJson(data);
     switch(baseResponse.statusCode){
       case 200:
         if(baseResponse.data.item1){
          Fluttertoast.showToast(msg: "登陆成功");
          sharedPreferences.setString("userName",userName);
          sharedPreferences.setString("adminToken",baseResponse.data.item2);
          Store.value<ConfigModel>(context)
              .initTheme("blue");

          /*跳到主界面*/
           NavigatorUtil.goMainPage(context);
         }else{
           Fluttertoast.showToast(msg: baseResponse.data.item2);
         }
         break;
     }

   });
  }


}