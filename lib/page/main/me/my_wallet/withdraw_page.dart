import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/bean/base_response.dart';
import 'package:flutter_app_zhkj_master/bean/get_bank_card_response.dart' as bank;
import 'package:flutter_app_zhkj_master/bean/get_withdraw_response.dart';
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
class WithdrawPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _WithdrawPage();
  }
}
  String moeny="";
  class _WithdrawPage extends State<WithdrawPage>{
  List<bank.Data> _Listbank = List();
  String _money="";
  String _canwithdraw="0.00";//可提现
  String _withdrawing="0.00";//提现中
  int _index=0;//默认显示第一张银行卡
  @override
  void initState() {
    super.initState();
    SpHelper.getUserName().then((username){
      _getMyBankCard(username);
      _getWithdrawResponse(username);
    });
    GlobalEventBus().eventBus.on<StateChangeEvent>().listen((event){
      if(event.state==EventConfig.NUM){
        if (mounted)
        setState(() {
          _money=moeny;
        });
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
    moeny="";
   // GlobalEventBus().eventBus.destroy();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255,240,240,240),
         appBar:  AppBar(
           title: Text("余额提现",
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
          flexibleSpace:
          Store.connect<ConfigModel>(
              builder: (context, ConfigModel snapshot, child) {
                return Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: ThemeUtil.setActionBar(snapshot.theme)
                      )
                  ),
                );
              }
          ),

          
      ),
      body: Column(
        children: <Widget>[
          /*选择银行卡*/
          GestureDetector(
            child:Container(
              height: 50,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey,width: 0.2),bottom: BorderSide(color: Colors.grey,width: 0.2))
              ),
              child: Row(
                children: <Widget>[
                  /*银行图片*/
                  Padding(
                    padding: EdgeInsets.only(left: 5,top: 3),
                    child:Image.asset(
                      ImageHelper.wrapAssets(_Listbank.length==0?"ic_zanwu.png":MyUtil.showBankLogo(_Listbank[_index].payInfoName)),width: 24,height: 24,)
                  ),

                  Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(_Listbank.length==0?"":"${_Listbank[_index].payInfoName} 尾号(${_Listbank[_index].payNo.substring(_Listbank[_index].payNo.length-4)})")
                  ),
                  Expanded(
                    child:
                    Container(
                        margin: EdgeInsets.only(right: 10),
                        alignment: Alignment.centerRight,
                        child: Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 16,height: 16,)
                     ),
                   )
                 ],
               ),
             ),
             onTap: (){
               NavigatorUtil.goSelectBankPage(context,_index.toString()).then((result){
                 //有返回值的时候
                 if(result!=null){
                   setState(() {
                     _index=result; //将选中的序号赋给_index;
                   });
                 }

              });
            },
          ),


          /*提现金额*/
          Container(
            margin: EdgeInsets.only(top: 14),
            width: double.infinity,
            height: 150,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding:EdgeInsets.only(left: 10,top: 10,bottom: 10),
                 child:
                 Row(
                   children: <Widget>[
                   Text("提现金额",style: TextStyle(color: Colors.grey)),
                   Text("(3%手续费)",style: TextStyle(color: Colors.red,fontSize: 9)),
                   Expanded(
                     child: Container(
                       padding: EdgeInsets.only(right: 10),
                       alignment: Alignment.centerRight,
                       child: Text("提现中:${_withdrawing}元",style: TextStyle(fontSize:10,color: Colors.green),)))
                 ],)

                ),

                //输入金额
                Row(
                  children: <Widget>[
                    Padding(
                        child: Text("¥",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w400)),
                        padding:EdgeInsets.only(left: 10)),
                        Expanded(
                           child:Container(
                             alignment: Alignment.centerLeft,
                             height: 35,
                             margin: EdgeInsets.only(left: 10,right: 10),
                             child: Store.connect<ConfigModel>(
                                 builder: (context, ConfigModel snapshot, child) {
                                   return  Text(_money,
                                     style: TextStyle(
                                         fontSize: 30,
                                         fontWeight: FontWeight.w600,
                                         color: ThemeUtil.SetFontColor(snapshot.theme)
                                     ),
                                   );
                                 }
                             ),

                            
                               ) ,
                           ),

                         /*点击清除数据*/
                         Offstage(
                           offstage: moeny==""?true:false,
                           child: 
                           GestureDetector(
                             child:
                             Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Image.asset(ImageHelper.wrapAssets("ic_close.png"),width: 22,height: 22)),
                             onTap: (){
                                moeny="";
                                setState(() {
                                _money="";
                               });
                               GlobalEventBus().eventBus.fire(StateChangeEvent(EventConfig.NUM));
                             },
                           ),
                         )
                  ],
                ),

                Container(
                  color: Colors.grey,
                  margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                  height: 0.2,
                ),
                Padding(padding: EdgeInsets.only(left: 10,top: 15),
                  child: Text("可提现余额${_canwithdraw}元",style: TextStyle(fontSize: 14,color: Colors.grey))
                )
              ],
            ),
          ),

          GestureDetector(
            child:


            Store.connect<ConfigModel>(
                builder: (context, ConfigModel snapshot, child) {
                  return   Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    margin: EdgeInsets.only(left: 10,top: 15,right: 19),
                    decoration: BoxDecoration(
                        color: ThemeUtil.SetFontColor(snapshot.theme),
                        borderRadius: BorderRadius.all(Radius.circular(4))
                    ),
                    child: Text("预计两天后到账,确认提现",style: TextStyle(color: Colors.white,fontSize: 18)),
                  );
                }
            ),

          
            onTap: (){
              if(moeny==""){
                Fluttertoast.showToast(msg: "请输入具体金额");
                return;
              }

              /*开始提现操作*/
              SpHelper.getUserName().then((username){
                _WithDraw(moeny, _Listbank[_index].payNo, username);
              });


            },)

          
          
      ]),
        bottomSheet: BottomKeyboard(),
    );
  }

  /*获取第一张银行卡作为默认提现*/
  _getMyBankCard(String UserID) async{
    var data=Map();
    data["UserID"]=UserID;
    await HttpUtils.post("Account/GetAccountPayInfoList", data).then((data){
      var getBankCardResponse = bank.GetBankCardResponse.fromJson(data);
      switch(getBankCardResponse.statusCode){
        case 200:
          setState(() {
            _Listbank=getBankCardResponse.data;
          });
          break;
      }
    });
  }

  //"Account/GetDepositMoneyDisplay"
  //{"StatusCode":200,"Info":"请求(或处理)成功","Data":{"bzj":"0.00","ktx":"12297352.00","txz":"0.97","dqr":"14695.00","ljtx":"0","ljsr":null}}
  _getWithdrawResponse(String UserID)async{
    var data=Map();
    data["UserID"]=UserID;
    await HttpUtils.post("Account/GetDepositMoneyDisplay", data).then((data){
     var getWithdrawResponse = GetWithdrawResponse.fromJson(data);
     switch(getWithdrawResponse.statusCode){
       case 200:
         setState(() {
           _canwithdraw=getWithdrawResponse.data.ktx;
           _withdrawing=getWithdrawResponse.data.txz;
         });

         break;
     }
    });
  }

  //http://47.96.126.145:8001/api/Account/WithDraw   提现
  _WithDraw(String DrawMoney,String CardNo,String UserID) async{
    var data =Map();
    data["DrawMoney"]=DrawMoney;
    data["CardNo"]=CardNo;
    data["UserID"]=UserID;
    await HttpUtils.post("Account/WithDraw", data).then((data){
      var baseResponse = BaseResponse.fromJson(data);
      switch(baseResponse.statusCode){
        case 200:
          if(baseResponse.data.item1){
            Fluttertoast.showToast(msg:  baseResponse.data.item2);
            GlobalEventBus().eventBus.fire(StateChangeEvent(EventConfig.MONENY));
            NavigatorUtil.goBack(context);
          }else{
            Fluttertoast.showToast(msg:  baseResponse.data.item2);
          }
          break;
      }
    });

  }






}

/*底部键盘*/
class BottomKeyboard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BottomKeyboard();
  }
}
class _BottomKeyboard extends State<BottomKeyboard>{
  int point_index=0;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 200,
        color: Color.fromARGB(255,240,240,240),
        child: Row(
          children: <Widget>[
            /*左边*/
            Expanded(
                flex: 3,
                child:
                Column(
                  children: <Widget>[
                    /*左边第一行*/
                    Row(
                      children: <Widget>[
                        /*1*/
                        Expanded(
                            child: Material(
                               child:Ink(
                                 color: Color.fromARGB(255,240,240,240),
                                 child:InkWell(
                                   child:Container(
                                     alignment: Alignment.center,
                                     height: 50,
                                     decoration: BoxDecoration(
                                  border: Border.all(width: 0.1,color: Colors.grey)
                                  ),
                                    child:Text("1",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w400))
                                ) ,
                                  onTap: () {
                                     _ChangeNum("1");
                                     },
                           ) ,
                          ) ,
                          )
                        ),
                        /*2*/
                        Expanded(
                            child: Material(
                              child:Ink(
                                color: Color.fromARGB(255,240,240,240),
                                child:InkWell(
                                  child:Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 0.1,color: Colors.grey)
                                      ),
                                      child:Text("2",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w400))
                                  ) ,
                                  onTap: (){
                                    _ChangeNum("2");
                                  },
                                ) ,
                              ) ,
                            )
                        ),
                        /*3*/
                        Expanded(
                            child: Material(
                              child:Ink(
                                color: Color.fromARGB(255,240,240,240),
                                child:InkWell(
                                  child:Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 0.1,color: Colors.grey)
                                      ),
                                      child:Text("3",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w400))
                                  ) ,
                                  onTap: (){
                                    _ChangeNum("3");
                                  },
                                ) ,
                              ) ,
                            )
                        ),

                      ],
                    ),
                    /*左边第二行*/
                    Row(
                      children: <Widget>[

                        /*4*/
                        Expanded(
                            child: Material(
                              child:Ink(
                                color: Color.fromARGB(255,240,240,240),
                                child:InkWell(
                                  child:Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 0.1,color: Colors.grey)
                                      ),
                                      child:Text("4",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w400))
                                  ) ,
                                  onTap: (){
                                    _ChangeNum("4");
                                  },
                                ) ,
                              ) ,
                            )
                        ),
                        /*5*/
                        Expanded(
                            child: Material(
                              child:Ink(
                                color: Color.fromARGB(255,240,240,240),
                                child:InkWell(
                                  child:Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 0.1,color: Colors.grey)
                                      ),
                                      child:Text("5",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w400))
                                  ) ,
                                  onTap: (){
                                    _ChangeNum("5");
                                  },
                                ) ,
                              ) ,
                            )
                        ),
                        /*6*/
                        Expanded(
                            child: Material(
                              child:Ink(
                                color: Color.fromARGB(255,240,240,240),
                                child:InkWell(
                                  child:Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 0.1,color: Colors.grey)
                                      ),
                                      child:Text("6",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w400))
                                  ) ,
                                  onTap: (){
                                    _ChangeNum("6");
                                  },
                                ) ,
                              ) ,
                            )
                        ),


                      ],
                    ),
                    /*左边第三行*/
                    Row(
                      children: <Widget>[
                        /*7*/
                        Expanded(
                            child: Material(
                              child:Ink(
                                color: Color.fromARGB(255,240,240,240),
                                child:InkWell(
                                  child:Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 0.1,color: Colors.grey)
                                      ),
                                      child:Text("7",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w400))
                                  ) ,
                                  onTap: (){
                                    _ChangeNum("7");
                                  },
                                ) ,
                              ) ,
                            )
                        ),
                        /*8*/
                        Expanded(
                            child: Material(
                              child:Ink(
                                color: Color.fromARGB(255,240,240,240),
                                child:InkWell(
                                  child:Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 0.1,color: Colors.grey)
                                      ),
                                      child:Text("8",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w400))
                                  ) ,
                                  onTap: (){
                                    _ChangeNum("8");
                                  },
                                ) ,
                              ) ,
                            )
                        ),
                        /*9*/
                        Expanded(
                            child: Material(
                              child:Ink(
                                color: Color.fromARGB(255,240,240,240),
                                child:InkWell(
                                  child:Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 0.1,color: Colors.grey)
                                      ),
                                      child:Text("9",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w400))
                                  ) ,
                                  onTap: (){
                                    _ChangeNum("9");
                                  },
                                ) ,
                              ) ,
                            )
                        ),



                      ],
                    ),
                    /*左边第四行*/
                    Row(
                      children: <Widget>[

                        /*.*/
                        Expanded(
                            child: Material(
                              child:Ink(
                                color: Color.fromARGB(255,240,240,240),
                                child:InkWell(
                                  child:Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 0.1,color: Colors.grey)
                                      ),
                                      child:Text(".",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w500))
                                  ) ,
                                  onTap: (){
                                    _ChangeNum(".");
                                  },
                                ) ,
                              ) ,
                            )
                        ),
                        /*0*/
                        Expanded(
                            child: Material(
                              child:Ink(
                                color: Color.fromARGB(255,240,240,240),
                                child:InkWell(
                                  child:Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 0.1,color: Colors.grey)
                                      ),
                                      child:Text("0",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w400))
                                  ) ,
                                  onTap: (){
                                    _ChangeNum("0");
                                  },
                                ) ,
                              ) ,
                            )
                        ),
                        /*键盘向下*/
                        Expanded(
                            child: Material(
                              child:Ink(
                                color: Color.fromARGB(255,240,240,240),
                                child:InkWell(
                                  child:Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 0.1,color: Colors.grey)
                                      ),
                                     // child:Text("键盘",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w400))
                                  ) ,
                                  onTap: (){

                                  },
                                ) ,
                              ) ,
                            )
                        ),


                      ],
                    ),

                  ],
                )

            ),
            /*右边*/
            Expanded(
                flex: 1,
                child:Column(
                  children: <Widget>[
                    /*删除一位*/
                   Expanded(
                       child: Material(
                         child:Ink(
                           color: Color.fromARGB(255,240,240,240),
                           child:InkWell(
                             child:Container(
                                 alignment: Alignment.center,
                                 height: 100,
                                 decoration: BoxDecoration(
                                     border: Border.all(width: 0.1,color: Colors.grey)
                                 ),
                                 child:Text("×",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400))
                             ) ,
                             onTap: (){
                               if(moeny!=""){
                                 print("执行了×长度为"+moeny.length.toString());
                                 setState(() {
                                   moeny=moeny.substring(0,moeny.length-1);
                                 });
                                 GlobalEventBus().eventBus.fire(StateChangeEvent(EventConfig.NUM));
                               }


                             },
                           ) ,
                         ) ,
                       )
                   ),
                      Expanded(
                          child: Material(
                           child: Ink(
                            color: Color.fromARGB(255,240,240,240),
                            child: InkWell(
                              child: Store.connect<ConfigModel>(
                                  builder: (context, ConfigModel snapshot, child) {
                                    return Container(
                                        alignment: Alignment.center,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 0.1,color: Colors.grey),
                                          color: ThemeUtil.SetFontColor(snapshot.theme),
                                        ),
                                        child:Text("确定",style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white))
                                     );
                                  }
                               ),


                         ),
                        ),
                      )
                     ),
                  ],
                )
            ),
          ],




        ),

    );
  }





   _getpointindex(){ //获取小数点的位置
    if(moeny.contains(".")){
      for(int i=0;i<moeny.length;i++){
        if(moeny[i]=="."){
          return i+1;
        }
      }
    }else{
      return -1;
    }
   }

   _ChangeNum(String s) {
   if(_getpointindex()!=-1 && moeny.length-_getpointindex()==2){
       return;
   }


   switch(s){
      case "0":
        if(moeny==""){
          return;
        }
        moeny+="0";
        break;
      case "1":
        moeny+="1";
        break;
      case "2":
        moeny+="2";
        break;
      case "3":
        moeny+="3";
        break;
      case "4":
        moeny+="4";
        break;
      case "5":
        moeny+="5";
        break;
      case "6":
        moeny+="6";
        break;
      case "7":
        moeny+="7";
        break;
      case "8":
        moeny+="8";
        break;
      case "9":
        moeny+="9";
        break;
      case ".":
        if(moeny.contains(".")||moeny==""){
          return;
        }
        moeny+=".";
        break;
      case "×":
        break;
    }
    GlobalEventBus().eventBus.fire(StateChangeEvent(EventConfig.NUM));

  }
}
