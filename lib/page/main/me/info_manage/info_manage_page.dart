
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/bean/base_response.dart';
import 'package:flutter_app_zhkj_master/bean/info_result.dart';
import 'package:flutter_app_zhkj_master/config/config.dart';
import 'package:flutter_app_zhkj_master/config/eventconfig.dart';
import 'package:flutter_app_zhkj_master/eventbus/global_eventbus.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/http/http_utils.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_app_zhkj_master/provider/index.dart';
import 'package:flutter_app_zhkj_master/provider/model/ConfigModel.dart';
import 'package:flutter_app_zhkj_master/provider/model/UserModel.dart';
import 'package:flutter_app_zhkj_master/provider/sp_helper.dart';
import 'package:flutter_app_zhkj_master/provider/theme_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

/*个人信息管理页面*/
class MyInfoManagePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyInfoManagePage();
  }
}

class _MyInfoManagePage extends State<MyInfoManagePage>{

     @override
    void dispose() {
    super.dispose();
   // GlobalEventBus().eventBus.destroy();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.fromARGB(255,245,242,245),
      appBar: AppBar(
        title: Text("个人信息管理",
          style:TextStyle(
            fontSize: 15,
            color: Colors.white
          ),
        ),
        centerTitle: true,
        leading: IconButton(icon: Image.asset(
       ImageHelper.wrapAssets("icon_actionbar_return.png"),
        width: 20,
        height: 20,
        ), onPressed: (){ Navigator.pop(context);}
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
      /*  Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.cyan,Colors.blue,Colors.blueAccent,Colors.blue,Colors.cyan]
              )
          ),
        ) ,
        */
      ),
      body:
      //滚动
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            /*-------头像-------*/
            Container(
                child:Row(
                  children: <Widget>[
                    Expanded(child: Text("头像",style:text_style)),
                    GestureDetector(child:
                    Row(children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child:
                          Store.connect<UserModel>(
                              builder: (context, UserModel snapshot, child) {
                                return Image.network(
                                  Config.HEAD_URL+"${snapshot.avator}",
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill, //图片填充方式
                                );
                              }
                          ),
                      ),

                      Image.asset(
                          ImageHelper.wrapAssets("right_arrow.png"),
                          width: 20,height: 20)
                    ]
                    ),
                      onTap: (){
                      /*点击弹出底部选择拍摄还是相册*/
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context){
                            return Container(
                              height: 140,
                              child:Column(
                                children: <Widget>[
                                  /*更换头像*/
                                  GestureDetector(
                                    child: Container(
                                      child: Text("更换头像",style: TextStyle(fontSize: 16,color: Colors.black54)),
                                      padding: EdgeInsets.only(top: 12,bottom: 12),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(bottom: BorderSide(color: Color.fromARGB(255,213,215,214)))
                                    ),
                                    alignment: Alignment.center,
                                  ),onTap: () async {
                                    Navigator.pop(context);
                                    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                                    if(image!=null){
                                       //调用更换头像的接口
                                       _upLoadImage(image);
                                   }
                                  }),


                                  /*查看大图*/
                                 GestureDetector(
                                     child:
                                     Container(
                                       child: Text("查看大图",style: TextStyle(fontSize: 16,color: Colors.black54)),
                                       padding: EdgeInsets.only(top: 12,bottom: 12),
                                       decoration: BoxDecoration(
                                       color: Colors.white,
                                       border: Border(bottom: BorderSide(color:Color.fromARGB(255,213,215,214)))
                                       ),
                                       alignment: Alignment.center,
                                       ),
                                     onTap: (){
                                       Navigator.pop(context);
                                     //  Navigator.of(context).pushNamed("lookpic");
                                       NavigatorUtil.goHeadPicPage(context);

                                    }
                                 ),

                                  /*取消*/
                                  GestureDetector(
                                    child:Container(
                                    child: Text("取消",style: TextStyle(fontSize: 16,color: Colors.black54)),
                                    padding: EdgeInsets.only(top: 12,bottom: 12),
                                    alignment: Alignment.center,
                                  ),
                                    onTap: (){
                                        Navigator.pop(context);
                                    },
                                  )
                                ],
                              )
                            );
                          }
                         );
                      },
                     )

                    /*圆形头像*/
                  ],
                ),
                padding: EdgeInsets.only(left: 10,right: 10),
                margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                ),
              ),




            /*线*/
            Container(
              color: Color.fromARGB(255,228,228,228),
              height: 1,
              margin: EdgeInsets.only(left: 10,right: 10),
            ),


            /*-------店铺名称-------*/

            GestureDetector(child: Container(
               child:Row(
                 children: <Widget>[
                   Expanded(child: Text("店铺名称",style: text_style)),
                   Store.connect<UserModel>(
                       builder: (context, UserModel snapshot, child) {
                         return Text(
                             '${snapshot.nickname}',
                             style: TextStyle(fontSize: 12)
                         );
                      }
                   ),
                     Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 20,height: 20),
               ],
               ),
               padding: EdgeInsets.only(left: 10,right: 10),
               margin: EdgeInsets.only(left: 10,right: 10),
               height: 60,
               color: Colors.white,
               ),
              onTap: (){
              NavigatorUtil.goUpDateNamePage(context);

              },
            ),




            /*-------姓名-------*/
            Container(
              child:Row(
                children: <Widget>[
                  Expanded(child: Text("姓名",style: text_style)),
                  Padding(padding: EdgeInsets.only(right: 10),
                      child:
                      Store.connect<UserModel>(
                          builder: (context, UserModel snapshot, child) {
                            return Text(
                                '${snapshot.truename}',
                                 style: TextStyle(fontSize: 14)
                            );
                          }
                      ),
                  ),

                  /*认证标签*/
                  Container(
                    padding: EdgeInsets.only(top: 2,bottom: 2,left: 3,right: 3),
                    decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 255,203,199))
                    ),
                    child:
                    Store.connect<UserModel>(
                        builder: (context, UserModel snapshot, child) {
                          String _ifauth="";
                          if("${snapshot.ifauth}"==null){
                            _ifauth="未认证";
                          }else if("${snapshot.ifauth}"=="1"){
                            _ifauth="已认证";
                          }else if("${snapshot.ifauth}"=="0"){
                            _ifauth="认证中";
                          }else if("${snapshot.ifauth}"=="-1"){
                            _ifauth="审核不通过";
                          }
                          return Text(
                            _ifauth,
                            style: TextStyle(color: Color.fromARGB(255, 255,83,70),fontSize: 12),
                          );

                        }
                    ),
                  )



                ],
              ),
              padding: EdgeInsets.only(left: 10,right: 10),
              margin: EdgeInsets.only(left: 10,right: 10,top: 10),
              height: 60,
              color: Colors.white,
            ),
            /*线*/
            Container(
              color: Color.fromARGB(255,228,228,228),
              height: 1,
              margin: EdgeInsets.only(left: 10,right: 10),
            ),

            /*-------修改密码-------*/


            GestureDetector(
              child:Container(
                child:Row(
                  children: <Widget>[
                    Expanded(child: Text("修改密码",style: text_style)),
                      Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 20,height: 20),
                  ],
                ),
                padding: EdgeInsets.only(left: 10,right: 10),
                margin: EdgeInsets.only(left: 10,right: 10),
                height: 60,
                color: Colors.white,
              ),
              onTap: (){
                NavigatorUtil.goModPassWordPage(context);
              }
              ),


            /*-------身份证-------*/
            Container(
              child:Row(
                children: <Widget>[
                  Expanded(child: Text("身份证",style: text_style)),
                  Store.connect<UserModel>(
                      builder: (context, UserModel snapshot, child) {
                        String idcard="";
                        if("${snapshot.idcard}"==null){
                          idcard="未认证";
                        }else{
                          idcard=snapshot.idcard.replaceRange(6,14 , "**********");
                        }
                       return Text(idcard);
                      }
                  ),
                ],
              ),
              padding: EdgeInsets.only(left: 10,right: 10),
              margin: EdgeInsets.only(left: 10,right: 10,top: 10),
              height: 60,
              color: Colors.white,
            ),

            /*线*/
            Container(
              color: Color.fromARGB(255,228,228,228),
              height: 1,
              margin: EdgeInsets.only(left: 10,right: 10),
            ),

            /*-------服务区域-------*/

            GestureDetector(child:Container(
              child:Row(
                children: <Widget>[
                  Expanded(child: Text("修改服务区域",style: text_style)),
                  Text("点击修改"),
                  Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 20,height: 20),
                ],
              ),
              padding: EdgeInsets.only(left: 10,right: 10),
              margin: EdgeInsets.only(left: 10,right: 10),
              height: 60,
              color: Colors.white,
            ),
              onTap: (){
             // Navigator.of(context).pushNamed("updateservicearea");
            NavigatorUtil.goUpdateServicePage(context);

              },
            ),


            /*-------店铺地址------*/
            Container(
              child:Row(
                children: <Widget>[
                  Padding(
                  padding: EdgeInsets.only(right: 20),
                  child:Text("店铺地址",style: text_style)),
                  Expanded(
                      child:
                      Store.connect<UserModel>(
                          builder: (context, UserModel snapshot, child) {
                            return Text(
                                '${snapshot.address}'
                            );
                          }
                      ),
                  )

                ],
              ),
              padding: EdgeInsets.only(left: 10,right: 10),
              margin: EdgeInsets.only(left: 10,right: 10,top:10),
              height: 60,
              color: Colors.white,
            ),


            /*线*/
            Container(
              color: Color.fromARGB(255,228,228,228),
              height: 1,
              margin: EdgeInsets.only(left: 10,right: 10),
            ),


            /*-------性别-------*/
            GestureDetector(
              child:Container(
              child:Row(
                children: <Widget>[
                  Expanded(child: Text("性别",style: text_style)),
                  Store.connect<UserModel>(
                      builder: (context, UserModel snapshot, child) {
                        return Text(
                            '${snapshot.sex}',
                             style: TextStyle(fontSize: 14)
                        );
                      }
                  ),
                  Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 20,height: 20),
                ],
              ),
              padding: EdgeInsets.only(left: 10,right: 10),
              margin: EdgeInsets.only(left: 10,right: 10),
              height: 60,
              color: Colors.white,
            ) ,onTap: (){
                /*弹出性别选择*/
                showModalBottomSheet(
                context: context,
                builder: (BuildContext context){
                  return Container(
                      height: 160,
                      child:Column(
                        children: <Widget>[
                          /*男*/
                          GestureDetector(
                              child: Container(
                                child: Text("男",style: TextStyle(fontSize: 16,color: Colors.black54)),
                                padding: EdgeInsets.only(top: 14,bottom: 14),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(bottom: BorderSide(color: Color.fromARGB(255,213,215,214)))
                                ),
                                alignment: Alignment.center,
                              ),onTap: (){
                                SpHelper.getUserName().then((username)=>
                                    _uploadSex(username,"男")
                                );
                            Navigator.pop(context);
                          }
                          ),

                          /*女*/
                          GestureDetector(
                              child:
                              Container(
                                child: Text("女",style: TextStyle(fontSize: 16,color: Colors.black54)),
                                padding: EdgeInsets.only(top: 14,bottom: 14),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(bottom:
                                    BorderSide(color:Color.fromARGB(255,213,215,214),width: 8)
                                    )
                                ),
                                alignment: Alignment.center,
                              ),
                              onTap: (){
                                SpHelper.getUserName().then((username)=>
                                    _uploadSex(username,"女")
                                );
                                Navigator.pop(context);
                              }
                          ),

                          /*取消*/
                          GestureDetector(
                            child:Container(
                              child: Text("取消",style: TextStyle(fontSize: 16,color: Colors.black54)),
                              padding: EdgeInsets.only(top:14,bottom: 12),
                              alignment: Alignment.center,
                            ),
                             onTap: (){
                              Navigator.pop(context);
                            },
                          )
                        ],
                      )
                  );
                }
                );
            }),


            /*线*/
            Container(
              color: Color.fromARGB(255,228,228,228),
              height: 1,
              margin: EdgeInsets.only(left: 10,right: 10),
            ),

            /*-------我的技能-------*/

            GestureDetector(
              child:Container(
                child:Row(
                  children: <Widget>[
                    Expanded(child: Text("我的技能",style: text_style)),
                    Text("修改生活技能"),
                    Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 20,height: 20),
                  ],
                ),
                padding: EdgeInsets.only(left: 10,right: 10),
                margin: EdgeInsets.only(left: 10,right: 10),
                height: 60,
                color: Colors.white,
              ),onTap: (){

                  Fluttertoast.showToast(msg: "暂未开发");

            },)


          ],
        ),
      )
    );

  }



  /*统一字体样式*/
  var text_style=TextStyle(
    fontSize: 14,
    color: Color.fromARGB(255, 133, 133, 133)
  );

     /*获取个人信息*/

   /*上传头像*/
   _upLoadImage(File image) async{
    String path=image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
    FormData formData =FormData.from({
       "UserID":Store.value<UserModel>(context).userid,
       "img":UploadFileInfo(File(path), name,contentType: ContentType.parse("image/$suffix"))
    });

     await HttpUtils.post("Upload/UploadAvator", formData).then((data){
       var baseResponse = BaseResponse.fromJson(data);
       switch(baseResponse.statusCode){
         case 200:
            if(baseResponse.data.item1){
              Store.value<UserModel>(context).setHead(baseResponse.data.item2);
            }
           break;
       }
     });
   }

   /*更改性别*/
  _uploadSex(String UserID,String Sex) async{
    var map=Map();
    map["UserID"]=UserID;
    map["Sex"]=Sex;
    await HttpUtils.post("Account/UpdateSex", map).then((data){
      var baseResponse = BaseResponse.fromJson(data);
      switch(baseResponse.statusCode){
        case 200:
          if(baseResponse.data.item1){
            Fluttertoast.showToast(msg: "性别更改成功");
            Store.value<UserModel>(context).setSex(Sex);
          }
          break;
      }

    });
    
  }


}


/*大图显示*/
class LookPic extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child:ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child:
          Store.connect<UserModel>(
              builder: (context, UserModel snapshot, child) {
                return Image.network(
                  Config.HEAD_URL+"${snapshot.avator}",
                  fit: BoxFit.contain, //图片填充方式
                );
              }
          ),
      ),
    );
  }

}


