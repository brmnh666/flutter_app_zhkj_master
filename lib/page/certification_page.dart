

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
/*实名认证*/
class CertificationPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CertificationPage();
  }
}
class _CertificationPage extends State<CertificationPage>{
  String _sex="";
  File _photo_0;//身份证正面
  File _photo_1;//身份证背面
  File _photo_2;//正面人脸


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247,247,247),
        appBar: AppBar(
          title: Text("实名认证",
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
          ), onPressed: (){
            NavigatorUtil.goBack(context);
          }
          ),
          flexibleSpace:Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.cyan,Colors.blue,Colors.blueAccent,Colors.blue,Colors.cyan]
                )
            ),
          ) ,
        ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.cyan,Colors.blue,Colors.blueAccent,Colors.blue,Colors.cyan]
                      )
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 10,right: 10,top: 25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                         topLeft: Radius.circular(8),
                         topRight: Radius.circular(8)
                      )
                  ),
                  child: 
                  Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(ImageHelper.wrapAssets("verified.png"),width: 20,height: 20),
                            Padding(padding: EdgeInsets.only(left: 5),
                            child:Text("未认证",style: TextStyle(fontSize: 14,color: Color.fromARGB(255, 90,90,91))),
                            )
                          ],
                        ),
                      ),
                      /*横线*/
                      Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        color: Color.fromARGB(255,228,228,228),
                        height: 1,
                      ),

                      /*真实姓名*/
                      Container(
                        height: 60,
                        child:Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child:  Text("真实姓名"),
                            ),
                            Expanded(
                                child:
                                    Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child:  TextField(
                                        textDirection: TextDirection.rtl,
                                         decoration: InputDecoration(
                                            disabledBorder: InputBorder.none,
                                            enabledBorder:  InputBorder.none,
                                            focusedBorder:   InputBorder.none,
                                            hintText: "请输入真实姓名否则无法体现",
                                            hintStyle: TextStyle(
                                                 fontSize: 10,
                                                color: Colors.red,
                                            )
                                        ),
                                      ),
                                    )
                            )

                          ],
                        ),
                      ),
                      /*横线*/
                      Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        color: Color.fromARGB(255,228,228,228),
                        height: 1,
                      ),

                      /*性别*/
                      GestureDetector(
                        child:Container(
                          height: 60,
                          child:Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 10,right: 10),
                                child:  Text("性别"),
                              ),
                              Expanded(
                                child:
                                Container(
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(right: 5),
                                    child:  Text(_sex)
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 15,height: 15)
                              )
                            ],
                          ),
                        ),
                        onTap: (){
                          /*弹出性别选择*/
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context){
                                return Container(
                                    height: 100,
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
                                              setState(() {
                                                _sex="男";
                                              });
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
                                              ),
                                              alignment: Alignment.center,
                                            ),
                                            onTap: (){
                                              setState(() {
                                                _sex="女";
                                              });
                                              Navigator.pop(context);
                                            }
                                        ),

                                      ],
                                    )
                                );
                              }
                          );

                        },
                      ),

                      /*横线*/
                      Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        color: Color.fromARGB(255,228,228,228),
                        height: 1,
                      ),

                      /*身份证号*/
                      Container(
                        height: 60,
                        child:Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child:  Text("身份证号码"),
                            ),
                            Expanded(
                                child:
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child:  TextField(
                                    textDirection: TextDirection.rtl,
                                    decoration: InputDecoration(
                                        disabledBorder: InputBorder.none,
                                        enabledBorder:  InputBorder.none,
                                        focusedBorder:   InputBorder.none,
                                        hintText: "请输入真实的身份证号码",
                                        hintStyle: TextStyle(
                                          fontSize: 10,
                                          color: Colors.red,
                                        )
                                    ),
                                  ),
                                )
                            )

                          ],
                        ),
                      ),

                      /*横线*/
                      Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        color: Color.fromARGB(255,228,228,228),
                        height: 1,
                      ),

                      /*身份证照*/
                      Container(
                        height: 80,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            /*身份证照*/
                            Expanded(
                                flex: 1,
                                child:
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child:Text("身份证照"))
                            ),

                            /*身份证照正面*/
                            Expanded(
                                flex: 1,
                                child:
                                GestureDetector(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      /*判断是否有图片没有就显示默认*/
                                      _photo_0==null
                                      ?Image.asset(ImageHelper.wrapAssets("positive.png"),width: 70,height: 48)
                                      :Image.file(_photo_0,width: 70,height: 48),
                                      Text("身份证正面",style: TextStyle(fontSize: 12))
                                    ],
                                  ) ,
                                  onTap: (){
                                  _showpopuewindow(0);
                                   },)
                            ),


                            /*身份证照反面*/

                              Expanded(
                                  flex: 1,
                                  child:
                                  GestureDetector(
                                  child:Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      _photo_1==null
                                          ?Image.asset(ImageHelper.wrapAssets("negative.png"),width: 70,height: 48)
                                          :Image.file(_photo_1,width: 70,height: 48),
                                      Text("身份证反面",style: TextStyle(fontSize: 12))
                                    ],
                                  ) ,
                                  onTap: (){
                                    _showpopuewindow(1);
                                  },)

                              ),

                            /*身份证照正面人脸*/
                               Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    child:Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        _photo_2==null
                                            ?Image.asset(ImageHelper.wrapAssets("positive.png"),width: 70,height: 48)
                                            :Image.file(_photo_2,width: 70,height: 48),
                                        Text("正面人脸照",style: TextStyle(fontSize: 12))
                                      ],
                                    ) ,
                                    onTap: (){
                                    _showpopuewindow(2);
                                  },)

                              ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),


              ],
            ),

            /*选择服务区域*/
            Container(
              margin: EdgeInsets.only(top: 10,left: 10,right: 10),
              height: 60,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: Text("选择服务区域")),
                    Expanded(child: Text("重要!请慎重选择",style: TextStyle(fontSize: 10,color: Colors.red))),
                    Padding(padding: EdgeInsets.only(right: 10),
                      child:  Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 15,height: 15)
                    )
                ],
              ),
            ),


            /*选择服务起点*/
            Container(
              margin: EdgeInsets.only(top: 10,left: 10,right: 10),
              height: 60,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Text("选择服务起点")),
                ],
              ),
            ),

            /*店铺地址*/
            Container(
              margin: EdgeInsets.only(top: 10,left: 10,right: 10),
              height: 120,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    height: 59,
                    child:
                     Row(children: <Widget>[
                        Text("店铺地址"),
                        Expanded(child:
                          Container(
                            alignment: Alignment.centerRight,
                            child:
                            Image.asset(ImageHelper.wrapAssets("positioning.png"),width: 15,height: 15))),
                            Padding(padding: EdgeInsets.only(right: 10),
                             child:Text("定位",style: TextStyle(fontSize: 16,color: Color.fromARGB(255,75,212,254))))
                      ],
                     )
                    ),
                  /*横线*/
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    color: Color.fromARGB(255,228,228,228),
                    height: 1,
                  ),
                  
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 10),
                    height: 60,
                    child: Text("浙江省宁波市企协大厦1212"),
                  )




                ],
              ),
            ),

            /*我的技能*/
            Container(
              margin: EdgeInsets.only(top: 10,left: 10,right: 10),
              height: 60,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Text("选择服务区域")),
                  Expanded(child: Text("请添加你的服务技能",style: TextStyle(fontSize: 10,color: Colors.red))),
                  Padding(padding: EdgeInsets.only(right: 10),
                      child:  Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 15,height: 15)
                  )
                ],
              ),
            ),

            /*提交申请*/
            GestureDetector(
              child: Container(

                child:Center(child:Text("提交申请",style: TextStyle(fontSize: 19,color: Colors.white))),
                padding: EdgeInsets.only(top: 13,bottom: 12),
                width: double.infinity,
                margin: EdgeInsets.only(left: 10,right: 10,top: 30,bottom: 20),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(5))
                ),
              ),
              onTap: ()
              {

              },
            )
            
            
            


          ],
        ),
      )
    );

  }
  /*底部弹出选择框*/
  _showpopuewindow(int position) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Container(
              height: 140,
              child:Column(
                children: <Widget>[
                  /*拍摄*/
                  GestureDetector(
                      child: Container(
                        child: Text("拍照",style: TextStyle(fontSize: 16,color: Colors.black54)),
                        padding: EdgeInsets.only(top: 12,bottom: 12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(bottom: BorderSide(color: Color.fromARGB(255,213,215,214)))
                        ),
                        alignment: Alignment.center,
                      ),onTap: () async {
                    Navigator.pop(context);
                    var image = await ImagePicker.pickImage(source: ImageSource.camera);
                    if(image!=null){
                      if(mounted)
                       setState(() {
                        switch(position){
                          case 0: //正面
                           _photo_0=image;
                            break;
                          case 1: //背面
                            _photo_1=image;
                            break;
                          case 2: //人正面
                          _photo_2=image;
                            break;
                        }
                      });
                    }else{
                      Fluttertoast.showToast(msg: "未选择图片");
                    }


                  }),


                  /*相册*/
                  GestureDetector(
                      child:
                      Container(
                        child: Text("相册",style: TextStyle(fontSize: 16,color: Colors.black54)),
                        padding: EdgeInsets.only(top: 12,bottom: 12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(bottom: BorderSide(color:Color.fromARGB(255,213,215,214)))
                        ),
                        alignment: Alignment.center,
                      ),
                      onTap: () async{
                        Navigator.pop(context);
                        var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                        if(image!=null){
                          if(mounted)
                            setState(() {
                              switch(position){
                                case 0: //正面
                                  _photo_0=image;
                                  break;
                                case 1: //背面
                                  _photo_1=image;
                                  break;
                                case 2: //人正面
                                  _photo_2=image;
                                  break;
                              }
                            });

                        }else{
                          Fluttertoast.showToast(msg: "未选择图片");
                        }

                        //NavigatorUtil.goHeadPicPage(context);

                      }
                  ),

                  /*取消*/
                  GestureDetector(
                    child:Container(
                      width: double.infinity,
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



  }

}