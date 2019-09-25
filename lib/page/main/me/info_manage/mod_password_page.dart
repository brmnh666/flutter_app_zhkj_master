
import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/bean/base_response.dart';
import 'package:flutter_app_zhkj_master/bean/info_result.dart';
import 'package:flutter_app_zhkj_master/http/http_utils.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_app_zhkj_master/provider/index.dart';
import 'package:flutter_app_zhkj_master/provider/model/ConfigModel.dart';
import 'package:flutter_app_zhkj_master/provider/sp_helper.dart';
import 'package:flutter_app_zhkj_master/provider/theme_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
/*修改密码*/
class MyModPassWordPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyModPassWordPage();
  }
}
class _MyModPassWordPage extends State<MyModPassWordPage>{
 InfoResult infoResult; //个人信息
 final TextEditingController controller_old=TextEditingController();
 final TextEditingController controller_new1=TextEditingController();
 final TextEditingController controller_new2=TextEditingController();

 @override
 void initState(){
   super.initState();
   SpHelper.getUserName().then((UserName)=> _GetInfo(UserName));
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,245,242,245),
      appBar: AppBar(
        title: Text("修改密码",
          style:TextStyle(
              fontSize: 18,
              color: Colors.white
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset(ImageHelper.wrapAssets("icon_actionbar_return.png"),
          width: 20,
          height: 20,
        ), onPressed: (){Navigator.pop(context);}
        ),
        flexibleSpace: Store.connect<ConfigModel>(
            builder: (context, ConfigModel snapshot, child) {
              return  Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: ThemeUtil.setActionBar(snapshot.theme)
                    )
                ),
              );
            }
        ),

       //Container(
       //  decoration: BoxDecoration(
       //      gradient: LinearGradient(
       //          colors: [Colors.cyan,Colors.blue,Colors.blueAccent,Colors.blue,Colors.cyan]
       //      )
       //  ),
       //) ,
      ),

      body: Column(
        children: <Widget>[
          /*当前密码*/
          Container(
            margin: EdgeInsets.only(top: 20,bottom: 10),
            padding: EdgeInsets.all(4),
            child:Row(children: <Widget>[
            Text("当前密码:",style: TextStyle(fontSize: 15)),
             Expanded(
                  child:
                  Padding(padding: EdgeInsets.only(left: 10),
                    child: TextField(
                    controller: controller_old,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue
                    ),
                    decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none
                    ),
                    keyboardType: TextInputType.text,
                    cursorWidth: 1,
                    cursorColor: Colors.black,
                    obscureText: true,
                  ),
                  )
              ),
          ]
          ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color.fromARGB(255, 213,215,214)))
            ),
          ),


          /*第一次密码*/
          Container(
            padding: EdgeInsets.all(4),
            child:Row(children: <Widget>[
              Text("新密码:",style: TextStyle(fontSize: 15)),
                 Expanded(
                    child: Padding(padding: EdgeInsets.only(left: 10),
                    child:
                    TextField(
                      controller: controller_new1,
                      obscureText: true,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue
                      ),
                      decoration: InputDecoration(
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none
                      ),
                      keyboardType: TextInputType.text,
                      cursorWidth: 1,
                      cursorColor: Colors.black,
                    )
                    )

                ),
            ]
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color.fromARGB(255, 213,215,214)))
            ),
          ),


          /*第二次密码*/
          Container(
            padding: EdgeInsets.all(4),
            child:Row(children: <Widget>[
              Text("新密码:",style: TextStyle(fontSize: 15)),
             Expanded(
                    child:Padding(padding: EdgeInsets.only(left: 10),
                    child:TextField(
                      controller: controller_new2,
                      obscureText: true,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue
                      ),
                      decoration: InputDecoration(
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "请再次输入新密码"
                      ),
                      keyboardType: TextInputType.text,
                      cursorWidth: 1,
                      cursorColor: Colors.black,
                    )
                    )
                ),
            ]
            ),
            decoration: BoxDecoration(
                color: Colors.white,
            ),
          ),
          
          /*确认按钮*/

          GestureDetector(
            child:

            Store.connect<ConfigModel>(
                builder: (context, ConfigModel snapshot, child) {
                  return Container(
                    child:Center(child:
                    Text("修改",style: TextStyle(fontSize: 15,color: Colors.white))),
                    padding: EdgeInsets.only(top: 12,bottom: 12),
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                    decoration: BoxDecoration(
                        color: ThemeUtil.SetFontColor(snapshot.theme),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                  );
                }
            ),
            onTap:(){
              if(controller_old.text==null||controller_old.text==""){
                Fluttertoast.showToast(msg: "请输入旧密码");
                return;
              }
              if(controller_new1.text==null||controller_new2.text==null||controller_new1.text==""||controller_new2.text==""){
                Fluttertoast.showToast(msg: "请输入新密码");
                return;
              }
              if(controller_old.text!=infoResult.data.data[0].passWord){
                Fluttertoast.showToast(msg: "当前密码不正确");
                return;
              }

              if(controller_new1.text!=controller_new2.text){
                Fluttertoast.showToast(msg: "两次密码不一致");
                return;
              }

               //可以修改密码哦
              SpHelper.getUserName().then((UserName)=> _ModPassWord(UserName,controller_new1.text));


            },
          )

        ]
      ),
    );
  }

  /*获取账号信息*/
 _GetInfo(String UserID ,{String limit="1"})async{
   var map=Map();
   map["UserID"]=UserID;
   map["limit"]=limit;
   await HttpUtils.post("Account/GetUserInfoList",map).then((data){
     var infoResult = InfoResult.fromJson(data);
     switch(infoResult.statusCode){
       case 200:
         this.infoResult=infoResult;
         break;
     }
   });
 }
  /*修改密码*/
  _ModPassWord(String UserID,String Password) async{
     var map=Map();
     map["UserID"]=UserID;
     map["Password"]=Password;
      await HttpUtils.post("Account/UpdatePassword", map).then((data){
        var baseResponse = BaseResponse.fromJson(data);
        switch(baseResponse.statusCode){
          case 200:
            if(baseResponse.data.item1){
              Fluttertoast.showToast(msg: "密码修改成功");
              Navigator.pop(context);
            }
            break;

        }

      });

  }


}