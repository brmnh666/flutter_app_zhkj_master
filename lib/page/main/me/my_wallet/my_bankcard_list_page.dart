import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/bean/get_bank_card_response.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/http/http_utils.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_app_zhkj_master/provider/sp_helper.dart';
import 'package:flutter_app_zhkj_master/util/my_util.dart';

/*我的银行卡页面*/
class BankCardList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _BankCardList();
  }
}
class _BankCardList extends State<BankCardList>{
  List<Data> _Listbank = List();

  @override
  void initState(){
    super.initState();
    SpHelper.getUserName().then((username)=>_getMyBankCard(username));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,240,240,240),
      appBar: AppBar(
        title: Text("我的银行卡",
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
        ), onPressed: () {
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
      body:
      SingleChildScrollView(
        child:Column(
          children: <Widget>[
             Container(
               height:  _getHeight(),
               width: double.infinity,
               child: ListView.builder(
                 itemCount: _Listbank==0?0:_Listbank.length,
                 physics: NeverScrollableScrollPhysics(),
                 itemBuilder: (context,index){
                   return Container(
                     margin: EdgeInsets.only(left: 10,right: 10),
                     height: 160,
                     child: Card(
                       color: MyUtil.BackGroundColor(_Listbank[index].payInfoName),
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
                             ImageHelper.wrapAssets(MyUtil.showBankLogo(_Listbank[index].payInfoName))),
                         ),
                         /*银行名*/
                         Container(
                           margin: EdgeInsets.only(left: 70,top: 20),
                           child: Text(_Listbank[index].payInfoName,style: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.w500),),
                         ),

                         /*卡号*/
                         Container(
                           margin: EdgeInsets.only(bottom: 15,right: 10),
                           alignment: Alignment.bottomRight,
                           child: Text(
                             "${_Listbank[index].payNo.substring(0,4)} **** **** ${_Listbank[index].payNo.substring(_Listbank[index].payNo.length-4,_Listbank[index].payNo.length)}"
                             ,style: TextStyle(color: Colors.white,fontSize:15),),
                         )

                       ],
                       ),
                     ),
                   );
                 }
             ),),

            /*添加银行卡*/
            GestureDetector(
              child:Container(
                height: 60,
                width: double.infinity,
                margin: EdgeInsets.only(top: 20,left: 13,right: 13),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.blue,width: 1)
                ),
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 10,right: 10),child: Image.asset(ImageHelper.wrapAssets("tianjia1.png"),width: 30,height: 30)),
                    Expanded(child:Text("添加银行卡",style: TextStyle(fontSize: 18))),
                    Padding(padding: EdgeInsets.only(right: 5),child:Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 20,height: 20) ,)
                  ],
                ),
              ),
            onTap: (){
               NavigatorUtil.goAddBankCardPage(context);
            },
            ),
            /*小贴士*/
            Container(
              margin: EdgeInsets.only(top: 25,left: 20,right: 20,bottom: 10),
              child:Row(children: <Widget>[
                  Expanded(child: Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 0.5,color: Colors.grey),flex: 3),
                  Expanded(
                    child: Text("小贴士"),flex: 1),
                  Expanded(child: Container(
                    margin: EdgeInsets.only(left: 10),
                      height: 0.5,color: Colors.grey),flex: 3)
              ],
              ),
            ),
            /*西瓜鱼温馨提示*/
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 13,top: 10),
              child: Text("西瓜鱼温馨提示",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500)),
            ),

            /*提示*/
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 13,top: 10,bottom: 20),
              child: Text("为了保障您的资金安全，您在西瓜鱼平台所绑定的银行卡必须与户名匹配，否则，您的资金将无法转入到您的账户中。",style: TextStyle(fontSize: 14,color: Colors.grey)),
            ),


          ],
        ),
      )
    );
  }

  /*height*/
   _getHeight(){
    if(_Listbank.length==0){
      return 0.0;
    }else{
      return (_Listbank.length*160).toDouble();
    }
  }

  /*设置银行卡背景颜色*//*
  Color _BackGroundColor(String bankname){
    if(bankname.contains("光大")){
      return Color.fromARGB(255,139,101,139);
    }
    if(bankname.contains("广发")){
      return Color.fromARGB(255,178,34,34);
    }
    if(bankname.contains("工商")){
      return Color.fromARGB(255,238,99,99);
    }
    if(bankname.contains("华夏")){
      return Color.fromARGB(255,255,0,0);
    }
    if(bankname.contains("建设")){
    return Color.fromARGB(255,30,144,255);
    }
    if(bankname.contains("交通")){
    return Color.fromARGB(255,65,105,225);
    }
    if(bankname.contains("民生")){
    return Color.fromARGB(255,0,191,255);
    }
    if(bankname.contains("宁波")){
      return Color.fromARGB(255,255,246,143);
    }
    if(bankname.contains("农业")){
      return Color.fromARGB(255,0,206,209);
    }
    if(bankname.contains("浦发")){
      return Color.fromARGB(255,0,0,205);
    }
    if(bankname.contains("兴业")){
      return Color.fromARGB(255,30,144,255);
    }
    if(bankname.contains("邮政")){
      return Color.fromARGB(255,0,100,0);
    }
    if(bankname.contains("招商")){
      return Color.fromARGB(255,238,121,66);
    }
    if(bankname.contains("浙商")){
      return Color.fromARGB(255,255,215,0);
    }
    if(bankname.contains("中国银行")){
      return Color.fromARGB(255,139,58,58);
    }
    if(bankname.contains("中信")){
      return Color.fromARGB(255,238,44,44);
    }
  }*/

  /*获取我的银行卡*/
  //"Account/GetAccountPayInfoList"
  _getMyBankCard(String UserID) async{
    var data=Map();
    data["UserID"]=UserID;
    await HttpUtils.post("Account/GetAccountPayInfoList", data).then((data){
      var getBankCardResponse = GetBankCardResponse.fromJson(data);
      switch(getBankCardResponse.statusCode){
        case 200:
          print(getBankCardResponse.data[0].isSelect);
          setState(() {
            _Listbank=getBankCardResponse.data;
          });
          break;
      }
    });
  }



}