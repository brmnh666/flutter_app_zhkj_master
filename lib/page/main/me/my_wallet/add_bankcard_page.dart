import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/bean/base_response.dart';
import 'package:flutter_app_zhkj_master/config/eventconfig.dart';
import 'package:flutter_app_zhkj_master/eventbus/global_eventbus.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/http/http_utils.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_app_zhkj_master/provider/index.dart';
import 'package:flutter_app_zhkj_master/provider/model/ConfigModel.dart';
import 'package:flutter_app_zhkj_master/provider/sp_helper.dart';
import 'package:flutter_app_zhkj_master/provider/theme_util.dart';
import 'package:flutter_app_zhkj_master/util/my_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';


class AddBankCardPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AddBankCardPage();
  }
}
class _AddBankCardPage extends State<AddBankCardPage>{
  TextEditingController _controller=TextEditingController();
  bool _isSuccess =false;
  String _bankname="";
  @override
  void initState() {
    super.initState();
    /*查询银行卡是否可用*/
    _controller.addListener((){
      if(_controller.text.length<6){
        setState(() {
          _isSuccess=false;
        });
      }
      if(_controller.text.length==6||_controller.text.length>=16){
        _GetSupportForCardNo(_controller.text.substring(0,6));
      }

    });

  }
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
                      child:
                      Store.connect<ConfigModel>(
                          builder: (context, ConfigModel snapshot, child) {
                            return Image.asset(ImageHelper.wrapAssets("arrow_left_blue${ThemeUtil.SetPhotoColor(snapshot.theme)}.png")
                                ,width: 28,height: 28);
                          }
                      ),

                    ),
                     onTap: (){
                    NavigatorUtil.goBack(context);
                  }),
                  /*问号提示可以绑定那些银行*/
                  Expanded(child: Store.connect<ConfigModel>(
                      builder: (context, ConfigModel snapshot, child) {
                        return Container(
                            alignment: Alignment.centerRight,
                            child:Padding(padding: EdgeInsets.only(right: 15,top: 15),
                                child:Image.asset(ImageHelper.wrapAssets("ic_wenhao${ThemeUtil.SetPhotoColor(snapshot.theme)}.png"),
                                    width: 28,height: 28))
                        );
                      }
                  ),
                  )
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


                   inputFormatters: <TextInputFormatter>[
                     WhitelistingTextInputFormatter.digitsOnly,//只输入数字
                     LengthLimitingTextInputFormatter(19)//限制长度
                   ],
                   //光标设置
                   cursorColor: Colors.black,
                   cursorWidth: 1,
                   keyboardType: TextInputType.number,
                 )
                 ),
                 GestureDetector(
                   child:Padding(
                         padding: EdgeInsets.only(right: 15),
                         child: Image.asset(ImageHelper.wrapAssets("ic_close.png"),width: 22,height: 22)),
                   onTap: (){
                     setState(() {
                       _controller.text="";
                       _isSuccess=false;
                       _bankname="";
                     });
                   },
                 )


               ],
             ),
           ),

            /*验证成功后我的银行卡片*/
            Offstage(
              offstage:!_isSuccess,
              child:  Container(
                width: double.infinity,
                height: 150,
                padding: EdgeInsets.only(top: 2,bottom:2 ),
                color: Colors.white,
                child:Card(
                  color: MyUtil.BackGroundColor(_bankname),
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
                          ImageHelper.wrapAssets(MyUtil.showBankLogo(_bankname))),
                    ),
                    /*银行名*/
                    Container(
                      margin: EdgeInsets.only(left: 70,top: 20),
                      child: Text(_bankname,style: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.w500),),
                    ),
                    /*卡号*/
                    Container(
                      margin: EdgeInsets.only(bottom: 15,right: 10),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "**** **** **** ****"
                        ,style: TextStyle(color: Colors.white,fontSize:15),),
                    )

                  ],
                  ),
                ),
              ),
            ),

            /*提交卡号*/
            Container(
              width: double.infinity,
              color: Colors.white,
              height: 80,
              child:
              _controller.text.length>=12&&_isSuccess?
                  GestureDetector(//满足条件可以添加
                    child:

                    Store.connect<ConfigModel>(
                        builder: (context, ConfigModel snapshot, child) {
                          return Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
                            decoration: BoxDecoration(
                                color: ThemeUtil.SetFontColor(snapshot.theme),
                                borderRadius: BorderRadius.all(Radius.circular(2))
                            ),
                            child: Text("提交卡号",style: TextStyle(color: Colors.white,fontSize: 18)),
                          );

                        }
                    ),
                    onTap: (){
                      SpHelper.getUserName().then(
                        (username)=>_addBankCard(username,"Bank",_bankname,_controller.text)
                      );

                     },
                     )
                    :

              Store.connect<ConfigModel>(
                  builder: (context, ConfigModel snapshot, child) {
                    return Container(//不满足条件不可以添加
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
                      decoration: BoxDecoration(
                          color: ThemeUtil.SetTransparencyColor(snapshot.theme),
                          borderRadius: BorderRadius.all(Radius.circular(2))
                      ),
                      child: Text("提交卡号",style: TextStyle(color:
                          ThemeUtil.SetFontColor(snapshot.theme),
                          fontSize: 18)),
                    );
                  }
              ),



            )

          ],

        ),
      ),
    );
  }

  /*根据银行卡号获取银行名 判断后台是否支持该银行的提现 6位数
*  {"StatusCode":200,"Info":"请求(或处理)成功","Data":{"Item1":true,"Item2":"中国工商银行"}}
* */
  _GetSupportForCardNo(String CardNo) async{
    var data=Map();
    data["CardNo"]=CardNo;
    await HttpUtils.post("Account/GetBankNameByCardNo", data).then((result){
      var baseResponse = BaseResponse.fromJson(result);
      switch(baseResponse.statusCode){
        case 200:
          if(baseResponse.data.item1){
            if(baseResponse.data.item2==""){
              setState(() {
              _isSuccess=false;
              });
            }else{
              setState(() {
                _isSuccess=true;
                _bankname=baseResponse.data.item2;
              });
            }
          }
          break;
      }
    }).catchError((error){
      print(error);
    });
  }

/*添加银行卡
*   @FormUrlEncoded
    @POST("Account/AddorUpdateAccountPayInfo")
    Observable<BaseResult<Data<String>>> AddorUpdateAccountPayInfo(@Field("UserID") String UserID,
                                                                   @Field("PayInfoCode") String PayInfoCode,
                                                                   @Field("PayInfoName") String PayInfoName,
                                                                   @Field("PayNo") String PayNo);
*
*{"StatusCode":200,"Info":"请求(或处理)成功","Data":{"Item1":true,"Item2":"39"}}
* */
_addBankCard(String UserID,String PayInfoCode,String PayInfoName,String PayNo)async{
var data=Map();
data["UserID"]=UserID;
data["PayInfoCode"]=PayInfoCode;
data["PayInfoName"]=PayInfoName;
data["PayNo"]=PayNo;
await HttpUtils.post("Account/AddorUpdateAccountPayInfo", data).then((result){
 var baseResponse = BaseResponse.fromJson(result);
 switch(baseResponse.statusCode){
   case 200:
     if(baseResponse.data.item1){
       Fluttertoast.showToast(msg: "添加成功");
       GlobalEventBus().eventBus.fire(StateChangeEvent(EventConfig.BANDCARD));
       NavigatorUtil.goBack(context);
     }
     break;

 }

});


}





}