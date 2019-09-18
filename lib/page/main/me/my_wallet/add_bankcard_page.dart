import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_app_zhkj_master/util/my_util.dart';

class AddBankCardPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AddBankCardPage();
  }
}
class _AddBankCardPage extends State<AddBankCardPage>{
  TextEditingController _controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,240,240,240),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            /*顶部appbar*/
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 60,
              child:
                Row(children: <Widget>[
                  GestureDetector(
                    child:Padding(padding: EdgeInsets.only(left: 15,top: 15),
                      child:Image.asset(ImageHelper.wrapAssets("arrow_left_blue.png"),width: 28,height: 28),),
                     onTap: (){
                    NavigatorUtil.goBack(context);
                  }),
                  /*问号提示可以绑定那些银行*/
                  Expanded(child: Container(
                      alignment: Alignment.centerRight,
                      child:Padding(padding: EdgeInsets.only(right: 15,top: 15),
                          child:Image.asset(ImageHelper.wrapAssets("ic_wenhao.png"),width: 28,height: 28))) )
                ],
                )

            ),


            /*顶部文字*/
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 90,
              color: Colors.white,
              child: Text("添加银行卡",style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w600)),
            ),
            /*提示添加本人银行卡*/
            Container(
              width: double.infinity,
              height: 40,
              padding: EdgeInsets.only(top: 10,left: 15),
              decoration: BoxDecoration(color: Colors.white,
                border: Border(bottom: BorderSide(width: 0.1,color: Colors.grey))
              ),
              child:
              RichText(
                text: TextSpan(
                  text: "请添加",
                  style: TextStyle(fontSize: 14,color: Colors.grey),
                  children: <TextSpan>[
                    TextSpan(
                      text: "本人",
                      style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w900)
                    ),
                    TextSpan(
                        text: "的银行卡",
                        style: TextStyle(fontSize: 14,color: Colors.grey)
                    )
                  ]

                ),

              )
            ),
            /*卡号*/
           Container(
             height: 48,
             decoration: BoxDecoration(
                  color: Colors.white,
                 border: Border(bottom: BorderSide(width: 0.1,color: Colors.grey))
             ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                 Padding(padding: EdgeInsets.only(left: 15,right: 15),
                   child:Text("卡号",style: TextStyle(fontSize: 18,))),
                 Expanded(child: TextField(
                   style: TextStyle(fontSize: 19,color: Colors.black,fontWeight: FontWeight.w400),
                   controller: _controller,
                   textDirection: TextDirection.ltr,
                   decoration: InputDecoration(
                     contentPadding: EdgeInsets.only(top: 5,bottom: 5),
                     disabledBorder: InputBorder.none,
                     enabledBorder:  InputBorder.none,
                     focusedBorder:   InputBorder.none,

                     hintText:"请绑定持卡人本人银行卡",
                     hintStyle: TextStyle(color: Colors.grey,fontSize: 19)
                   ),
                   //光标设置
                   cursorColor: Colors.black,
                   cursorWidth: 1,
                   keyboardType: TextInputType.number,
                 )
                 ),
                 Padding(
                     padding: EdgeInsets.only(right: 15),
                     child: Image.asset(ImageHelper.wrapAssets("ic_close.png"),width: 22,height: 22)),

               ],
             ),
           ),

            /*验证成功后我的银行卡片*/
            Container(
              width: double.infinity,
              height: 150,
              padding: EdgeInsets.only(top: 2,bottom:2 ),
               color: Colors.white,
               child:Card(
                 color: MyUtil.BackGroundColor("工商银行"),
                 child: Stack(children: <Widget>[
                   /*白色圆形背景*/
                   Container(
                     margin: EdgeInsets.only(left: 10,top: 10),
                     width: 50,
                     height: 50,
                     decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.all(Radius.circular(25))
                     ),
                   ),
                   /*银行logo*/
                   Container(
                     width: 40,
                     height: 40,
                     margin: EdgeInsets.only(left: 15,top: 15),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(25))
                     ),
                     child: Image.asset(
                         ImageHelper.wrapAssets("gongshang.png")),
                   ),
                   /*银行名*/
                   Container(
                     margin: EdgeInsets.only(left: 70,top: 20),
                     child: Text("工商银行",style: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.w500),),
                   ),
                   /*卡号*/
                   Container(
                     margin: EdgeInsets.only(bottom: 15,right: 10),
                     alignment: Alignment.bottomRight,
                     child: Text(
                       "1234 **** **** 1242"
                       ,style: TextStyle(color: Colors.white,fontSize:15),),
                   )

                 ],
                 ),
               ),
            ),
            /*提交卡号*/
            Container(
              width: double.infinity,
              color: Colors.white,
              height: 80,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(2))
                ),
                child: Text("提交卡号",style: TextStyle(color: Colors.white,fontSize: 16)),
              ),
            )



          ],

        ),
      ),
    );
  }
}