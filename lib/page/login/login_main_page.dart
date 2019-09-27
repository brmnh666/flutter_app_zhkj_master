/*登陆主界面*/
import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/bean/base_response.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/http/http_utils.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginMainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LoginMainPage();
  }
}

class _LoginMainPage extends State<LoginMainPage>{
   bool _isuser_login=false;
   String btn_str="手机号注册";
   TextEditingController controller_username=TextEditingController();
   TextEditingController controller_password=TextEditingController();
  Color _defaultColor=Color.fromARGB(255,47,136,254);

  @override
  void initState() {
    super.initState();
    controller_username.text="18892621501";
    controller_password.text="667675";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _defaultColor,
      body: Container(
        height: 400,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Container(
                margin: EdgeInsets.only(top: 10),
                 child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(ImageHelper.wrapAssets("ic_loginmain_yu.png"),width: 80,height: 80),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10,bottom: 5),
                        child: Text("西瓜鱼师傅",style: TextStyle(fontSize: 29,color: Colors.white,fontWeight: FontWeight.w500)),
                      ),

                    Container(
                      margin: EdgeInsets.only(left: 40),
                      child: Text("以服务为目标",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w500)),
                     )
                    ],
                   )
                 ],
               ),
              )
             ),
             Expanded(
               flex: 4,
                child: Offstage(offstage:!_isuser_login,
                  child: Container(
                   width: double.infinity,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Container(
                         margin: EdgeInsets.only(left: 40,right: 40,bottom: 5),
                         child:  Row(children: <Widget>[
                           Text("账号:",style: TextStyle(fontSize: 18,
                               color: Colors.white,
                               fontWeight: FontWeight.w500)),
                           Expanded(child:
                           Container(
                             margin: EdgeInsets.only(left: 8),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                 color: Colors.white,
                                 border: Border.all(color: Colors.grey,width: 0.3)
                             ),
                                child:TextField(
                                 //控制器 可以获取内容
                                  controller: controller_username,
                                 // controller: controller, //给TextField设置装饰（形状等）
                                 decoration: InputDecoration(
                                 disabledBorder: InputBorder.none,
                                 enabledBorder:  InputBorder.none,
                                 focusedBorder:   InputBorder.none,
                                 //输入内容距离上下左右的距离 ，可通过这个属性来控制 TextField的高度
                                 contentPadding: EdgeInsets.only(top: 10,bottom: 10,left: 10),
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
                           )
                           )
                         ],
                         ),
                       ),

                       Container(
                         margin: EdgeInsets.only(left: 40,right: 40,top: 5),
                         child:  Row(
                           children: <Widget>[
                             Text("密码:",style: TextStyle(fontSize: 18,
                                 color: Colors.white,
                                 fontWeight: FontWeight.w500)),
                             Expanded(child:
                              Container(
                               margin: EdgeInsets.only(left: 8),
                               decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.all(Radius.circular(4)),
                                   border: Border.all(color: Colors.grey,width: 0.3)
                               ),
                               child:  TextField(
                                 //控制器 可以获取内容
                                 controller: controller_password,
                                 // controller: controller, //给TextField设置装饰（形状等）
                                 decoration: InputDecoration(
                                   disabledBorder: InputBorder.none,
                                   enabledBorder:  InputBorder.none,
                                   focusedBorder:   InputBorder.none,
                                   //输入内容距离上下左右的距离 ，可通过这个属性来控制 TextField的高度
                                   contentPadding: EdgeInsets.only(top: 10,bottom: 10,left: 10),
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
                             )
                             )
                           ],
                         ),
                       )
                     ],
                   )
                  )
                ),

            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 200,
        child: Column(
          children: <Widget>[
            /*手机号注册*/
            GestureDetector(
              child:Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 45,
                margin: EdgeInsets.only(left: 40,right: 40),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child: Text(btn_str,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
              ),
            onTap: (){
                if(btn_str=="手机号注册"){
                  NavigatorUtil.goRegistPage(context);
                }else if(btn_str=="登录"){
                  if(controller_username.text==null||controller_username.text==""){
                    Fluttertoast.showToast(msg: "请输入手机号");
                    return;
                  }

                  if(controller_password.text==null||controller_password.text==""){
                    Fluttertoast.showToast(msg: "请输入密码");
                    return;
                  }

                 //showDialog<Null>(
                 //    context: context, //BuildContext对象
                 //    barrierDismissible: false,
                 //    builder: (BuildContext context) {
                 //      return  LoadingDialog( //调用对话框
                 //        text: '账号密码登录中...',
                 //        photourl: "iv_user_login.png",
                 //      );
                 //    }
                 //);

                  /*登陆*/
                  _Login(controller_username.text,controller_password.text);


                }
             },
            ),

            /*其他登陆方式*/
            Container(
              height: 100,
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /*手机号登陆*/
                    GestureDetector(
                      child:Container(
                          width: 55,
                          height: 55,
                          margin: EdgeInsets.only(left: 8,right: 8),
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.3,color: Colors.white),
                              color: Color.fromARGB(90,213,215,214),
                              borderRadius: BorderRadius.all(Radius.circular(30))
                          ),
                          child:
                          Padding(padding: EdgeInsets.all(10),
                              child:Image.asset(ImageHelper.wrapAssets("ic_home_login.png"))
                          )

                      ),
                      onTap: (){
                        setState(() {
                          _defaultColor=Color.fromARGB(255,47,136,254);
                          _isuser_login=false;
                          btn_str="手机号注册";
                        });

                      },
                    ),
                    /*账号密码登陆*/
                    GestureDetector(
                      child: Container(
                        width: 55,
                        height: 55,
                        margin: EdgeInsets.only(left: 8,right: 8),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.3,color: Colors.white),
                            color: Color.fromARGB(90,213,215,214),
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child:  Padding(padding: EdgeInsets.all(10),
                            child:Image.asset(ImageHelper.wrapAssets("ic_user_login.png"))
                        ),
                      ),
                      onTap: (){
                        setState(() {
                          _defaultColor=Color.fromARGB(255,47,136,254);
                          _isuser_login=true;
                          btn_str="登录";
                        });
                      },
                    ),


                    /*微信登陆*/
                    GestureDetector(
                      child:Container(
                        width: 55,
                        height: 55,
                        margin: EdgeInsets.only(left: 8,right: 8),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.3,color: Colors.white),
                            color: Color.fromARGB(90,213,215,214),
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child:  Padding(padding: EdgeInsets.all(10),
                            child:Image.asset(ImageHelper.wrapAssets("ic_wechat_login.png"))
                        ),
                      ),
                      onTap: (){
                        showDialog<Null>(
                            context: context, //BuildContext对象
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return LoadingDialog( //调用对话框
                                text: '微信登录中...',
                                photourl: "iv_wechat.png",
                                loadingcolor: Color.fromARGB(255, 88,188,71),
                              );
                            }
                        );
                        setState(() {
                          _defaultColor=Color.fromARGB(255, 88,188,71);
                          _isuser_login=false;
                          btn_str="手机号注册";
                        });
                     },
                    ),

                    /*微博登陆*/
                    GestureDetector(
                      child:Container(
                        width: 55,
                        height: 55,
                        margin: EdgeInsets.only(left: 8,right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.3,color: Colors.white),
                            color: Color.fromARGB(90,213,215,214),
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child:  Padding(padding: EdgeInsets.all(10),
                            child:Image.asset(ImageHelper.wrapAssets("ic_weibo_login.png"))
                        ),
                      ),
                      onTap: (){
                        showDialog<Null>(
                            context: context, //BuildContext对象
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return  LoadingDialog( //调用对话框
                                text: '微博登录中...',
                                photourl: "iv_weibo.png",
                                loadingcolor: Color.fromARGB(255, 241,152,0),
                              );
                             }
                            );
                      setState(() {
                        _defaultColor=Color.fromARGB(255, 241,152,0);
                        _isuser_login=false;
                        btn_str="手机号注册";
                      });
                     }
                    ),


                  ],
                ),
            ),
            /*用户协议*/
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("注册/登陆表示同意",style: TextStyle(fontSize: 11,color: Colors.white),),
                  Padding(padding: EdgeInsets.only(left: 5),
                    child: Text("《用户协议》",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500)),)
                ],
              ),
            )
          ],
        ),
      ),

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
             /*跳到主界面*/
             NavigatorUtil.goMainPage(context);

           }else{
             Fluttertoast.showToast(msg: baseResponse.data.item2);
           }
           break;
       }
      }
     );
   }
}

/*显示Loding框*/
class LoadingDialog extends Dialog {
  String photourl;
  String text;
  Color loadingcolor;
  LoadingDialog({this.photourl, this.text,this.loadingcolor});
  @override
  Widget build(BuildContext context) {
    return Material( //创建透明层
      type: MaterialType.transparency, //透明类型
      child:  Center( //保证控件居中效果
        child: SizedBox(
          width: 160.0,
          height: 160.0,
          child: Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(ImageHelper.wrapAssets(photourl),width: 65,height: 65),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                   Container(
                     margin:  EdgeInsets.only(top: 10.0,right: 10),
                    width: 15,
                    height: 15,
                    child:  CircularProgressIndicator(
                      strokeWidth: 3,
                      backgroundColor: loadingcolor,
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: 10.0),
                    child:  Text(text, style: TextStyle(fontSize: 13.0),
                    ),
                  ),

                ],)

              ],
            ),
          ),
        ),
      ),
    );
  }
}