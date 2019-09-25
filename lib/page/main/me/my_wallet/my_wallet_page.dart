

import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/bean/get_bank_card_response.dart';
import 'package:flutter_app_zhkj_master/bean/get_bill_response.dart';
import 'package:flutter_app_zhkj_master/bean/info_result.dart';
import 'package:flutter_app_zhkj_master/config/eventconfig.dart';
import 'package:flutter_app_zhkj_master/eventbus/global_eventbus.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/http/http_utils.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_app_zhkj_master/provider/index.dart';
import 'package:flutter_app_zhkj_master/provider/model/ConfigModel.dart';
import 'package:flutter_app_zhkj_master/provider/sp_helper.dart';
import 'package:flutter_app_zhkj_master/provider/theme_util.dart';

class MyWalletPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyWalletPage();
  }
}

class _MyWalletPage extends State<MyWalletPage>{

  String _totle="0.00";//总金额
  String _canwithdraw="0.00";//可以先
  String _unfinished="0.00";//未完结
  String _freeze="0.00";//冻结金额
  String _con="0.00";//西瓜币


  List<Data2> list_sz=List();//收支
  List<Data2> list_withdraw=List();//提现
  List<Data2> list_recharge=List();//充值
  String _bankcardnum="已绑定0张银行卡";

  @override
  void initState() {
    super.initState();
    SpHelper.getUserName().then((UserName){
    _getAccountBill(UserName, "1");
    _getAccountBill(UserName, "2,5");
    _getAccountBill(UserName, "3");
    _getuserinfolist(UserName);
    _getMyBankCard(UserName);
    });

    /*需要更新数据操作*/
    GlobalEventBus().eventBus.on<StateChangeEvent>().listen((event){
      if(event.state==EventConfig.MONENY){//更新余额
        if (mounted)
          setState(() {
            SpHelper.getUserName().then((UserName)=>_getuserinfolist(UserName)
            );
          });
      }
      if(event.state==EventConfig.BANDCARD){//银行卡
        if (mounted){
          setState(() {
            SpHelper.getUserName().then((UserName)=>_getMyBankCard(UserName)
            );
          });
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("我的钱包",
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

        elevation: 0.0,
      ),
      body:


      SingleChildScrollView(
        child:
        Column(children: <Widget>[
          Stack(
            children: <Widget>[

              Store.connect<ConfigModel>(
                  builder: (context, ConfigModel snapshot, child) {
                    return
                      Container(
                        width: double.infinity,
                        height: 75,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: ThemeUtil.setActionBar(snapshot.theme)
                            )
                        ),
                      );

                  }
               ),
              Container(
                width: double.infinity,
                height: 225,
                margin: EdgeInsets.only(top: 2,left: 10,right: 10),
                child: Card(
                  elevation: 3.0,
                  child: Column(
                    children: <Widget>[
                      /*总金额   充值提现*/
                      Expanded(child:
                      Row(children: <Widget>[
                        /*总金额*/
                        Expanded(
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child:Text("总金额",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color.fromARGB(255,125,125,125)
                                )
                                ),
                              ),

                              /*钱的具体数目*/
                              Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(_totle,style: TextStyle(color: Colors.blueAccent,fontSize: 30))

                              )
                            ],
                          ),
                          flex: 2,
                        ),

                        /*充值提现*/
                        Expanded(child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                             child:Container(
                               child:Text("充  值",style: TextStyle(fontSize: 15,color:Color.fromARGB(255, 99,99,99))),
                               margin: EdgeInsets.only(top:20,bottom: 8),
                               decoration:BoxDecoration(
                                   borderRadius: BorderRadius.all(Radius.circular(5)),
                                   border: Border.all(color: Color.fromARGB(255,199,199,199))
                               ) ,
                               padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                             ),
                             onTap: (){
                              NavigatorUtil.goRechargePage(context);
                            }),



                            /*提现*/
                            GestureDetector(
                              child:Container(child:Text("提  现",style: TextStyle(fontSize: 15,color:Color.fromARGB(255, 99,99,99))),
                                margin: EdgeInsets.only(top: 8),
                                decoration:BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color: Color.fromARGB(255,199,199,199))
                                ) ,
                                padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                              ) ,
                              onTap: (){
                                NavigatorUtil.goWithdrawPage(context);
                              },
                            )

                          ],
                        ),
                          flex: 1,
                        )
                      ],
                      )
                          ,flex: 4),
                      Expanded(child:
                      /*底部四个金额  可提现 未完结 冻结配件 西瓜币*/
                      Row(children: <Widget>[
                        /*可提现*/
                        Expanded(
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("可提现",style: TextStyle(color: Color.fromARGB(255,106,106,106))),
                                Text(_canwithdraw)
                              ],
                            ),
                            flex: 1),

                        /*未完结*/
                        Expanded(
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("未完结",style: TextStyle(color: Color.fromARGB(255,106,106,106))),
                                Text(_unfinished)
                              ],
                            ),
                            flex: 1),
                        /*冻结配件*/
                        Expanded(
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("冻结配件",style: TextStyle(color: Color.fromARGB(255,106,106,106))),
                                Text(_freeze)
                              ],
                            ),
                            flex: 1),
                        /*西瓜币*/
                        Expanded(
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("西瓜币",style: TextStyle(color: Color.fromARGB(255,106,106,106))),
                                Text(_con)
                              ],
                            ),
                            flex: 1),
                      ],
                      ),
                        flex: 3)

                    ],
                  ),
                ),
              )
            ],
          ),
        /*提现绑定*/
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            child: Card(
                elevation: 3.0,
                child:
                 /*图标和文字*/
               Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 20,bottom: 20,left: 10),
                      child: Row(
                        children: <Widget>[
                          Image.asset(ImageHelper.wrapAssets("payment.png"),width: 16,height: 16),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child:Text("提现绑定",style: TextStyle(color: Color.fromARGB(255,51,51,51),fontSize: 14)),
                          )
                        ],
                      ),
                    ),
                  /*横线*/
                    Container(
                      width: double.infinity,
                      height: 1,
                      margin: EdgeInsets.only(left: 12,right: 12),
                      color: Color.fromARGB(255, 231,231,231),
                    ),

                    /*银行卡*/
                    GestureDetector(
                      child:Padding(padding: EdgeInsets.only(top: 20,bottom: 20,left: 10),
                        child: Row(
                          children: <Widget>[
                            Image.asset(ImageHelper.wrapAssets("id_card.png"),width: 21,height: 21),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child:Text("银行卡",style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 42,60,112))),

                            ),
                            Expanded(child:Container(
                              alignment: Alignment.centerRight,

                              child: Text(_bankcardnum,style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 154,159,180)),),
                            )
                            ),
                            Padding(padding: EdgeInsets.only(right: 10),
                              child:Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 14,height: 17),

                            ),
                          ],
                        ),
                      ),
                      onTap: (){
                        NavigatorUtil.goMyBankCardListPage(context);
                    }),
                  ],
                ),
            ),
          ),

         /*收支明细*/
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            child: Card(
              elevation: 3.0,
              child:
              /*图标和文字*/
              Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 20,bottom: 20,left: 10),
                    child: Row(
                      children: <Widget>[
                        Image.asset(ImageHelper.wrapAssets("bill.png"),width: 16,height: 16),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child:Text("收支明细",style: TextStyle(color: Color.fromARGB(255,51,51,51),fontSize: 14)),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(right: 20),
                              alignment: Alignment.centerRight,
                              child:Text("更多")))
                      ],
                    ),
                  ),
                  /*横线*/
                  Container(
                    width: double.infinity,
                    height: 1,
                    margin: EdgeInsets.only(left: 12,right: 12),
                    color: Color.fromARGB(255, 231,231,231),
                  ),

                  /*收支明细*/
                  Container(
                      width: double.infinity,
                      height: _getContainerHeight(list_sz),
                      child:ListView.builder(
                           physics: NeverScrollableScrollPhysics(),
                           itemCount: list_sz.length==0?0:list_sz.length,
                           itemBuilder: (BuildContext context,int index){
                            return Container(
                              height: 50,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child:
                                    Container(
                                      child: Text(
                                          list_sz[index].createTime
                                              .replaceRange(4, 5, "年")
                                              .replaceRange(7, 8, "月")
                                              .replaceRange(10, 11,"日")
                                              .replaceRange(13, 14,"时")
                                              .replaceRange(16, 17, "分"),
                                           style: TextStyle(fontSize: 12),
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                    flex: 3,
                                  ),
                                  Expanded(
                                    child:
                                    Container(
                                      alignment: Alignment.center,
                                      child:Text(list_sz[index].stateName,
                                      style: TextStyle(color:list_sz[index].stateName=="收入"?Colors.green:Colors.red)),
                                    ),
                                    //Text(list_sz[index].stateName),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child:
                                    Container(
                                      alignment: Alignment.center,
                                      child:Text(list_sz[index].state=="5"? "+ ¥${list_sz[index].payMoney}": "- ¥${list_sz[index].payMoney}"),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              ),

                            );

                          }) ,
                  )

                ],

              ),
            ),
          ),


          /*提现记录*/
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            child: Card(
              elevation: 3.0,
              child:
              /*图标和文字*/
              Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 20,bottom: 20,left: 10),
                    child: Row(
                      children: <Widget>[
                        Image.asset(ImageHelper.wrapAssets("bill.png"),width: 16,height: 16),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child:Text("提现记录",style: TextStyle(color: Color.fromARGB(255,51,51,51),fontSize: 14)),
                        ),
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.only(right: 20),
                                alignment: Alignment.centerRight,
                                child:Text("更多")))
                      ],
                    ),
                  ),
                  /*横线*/
                  Container(
                    width: double.infinity,
                    height: 1,
                    margin: EdgeInsets.only(left: 12,right: 12),
                    color: Color.fromARGB(255, 231,231,231),
                  ),

                  Container(
                    width: double.infinity,
                    height: _getContainerHeight(list_withdraw),
                    child:ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: list_withdraw.length==0?0:list_withdraw.length,
                        itemBuilder: (BuildContext context,int index){
                          return Container(
                            height: 50,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child:
                                    Container(
                                      child: Text(
                                        list_withdraw[index].createTime
                                            .replaceRange(4, 5, "年")
                                            .replaceRange(7, 8, "月")
                                            .replaceRange(10, 11,"日")
                                            .replaceRange(13, 14,"时")
                                            .replaceRange(16, 17, "分"),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                    flex: 3,
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child:Text("提现",
                                        style: TextStyle(color:Colors.red)),
                                  ),
                                   flex: 1,
                                ),
                                Expanded(
                                    child:
                                    Container(
                                      alignment: Alignment.center,
                                      child:Text("- ${list_withdraw[index].payMoney}"),
                                    ),
                                  flex: 2,
                                ),
                              ],
                            ),

                          );

                        }) ,
                  )

                ],

              ),
            ),
          ),


          /*充值记录*/
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            child: Card(
              elevation: 3.0,
              child:
              /*图标和文字*/
              Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 20,bottom: 20,left: 10),
                    child: Row(
                      children: <Widget>[
                        Image.asset(ImageHelper.wrapAssets("bill.png"),width: 16,height: 16),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child:Text("充值记录",style: TextStyle(color: Color.fromARGB(255,51,51,51),fontSize: 14)),
                        ),
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.only(right: 20),
                                alignment: Alignment.centerRight,
                                child:Text("更多")))
                      ],
                    ),
                  ),
                  /*横线*/
                  Container(
                    width: double.infinity,
                    height: 1,
                    margin: EdgeInsets.only(left: 12,right: 12),
                    color: Color.fromARGB(255, 231,231,231),
                  ),
                  Container(
                    width: double.infinity,
                    height:_getContainerHeight(list_recharge),
                    child:ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: list_recharge==0?0:list_recharge.length,
                        itemBuilder: (BuildContext context,int index){
                          return Container(
                            height: 50,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child:
                                  Container(
                                    child: Text(
                                    list_recharge[index].createTime
                                    .replaceRange(4, 5, "年")
                                    .replaceRange(7, 8, "月")
                                    .replaceRange(10, 11,"日")
                                    .replaceRange(13, 14,"时")
                                    .replaceRange(16, 17, "分"),
                                         style: TextStyle(fontSize: 12),
                                             ),
                                    alignment: Alignment.center,
                                  ),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child:Text("充值",
                                        style: TextStyle(color:Colors.green)),
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child:Text("+ ${list_recharge[index].payMoney}"),
                                  ),
                                  flex: 2,
                                ),
                              ],
                            ),

                          );

                        }) ,
                  )

                ],

              ),
            ),
          ),

        ],
        )

      ),

    );
  }

  double _getContainerHeight(List list){
    if(list.length==0){
      return 50;
    }
    if(list.length<=5&&list.length>0){
      return (list.length*50).toDouble();
    }else{
      return 250;
    }

  }

  //"Account/AccountBill"
  //"1" 充值
  //"3" 提现
  //"2" 收入和"5"支出
  _getAccountBill(String UserID ,String state) async{
  var data=Map();
  data["UserID"]=UserID;
  data["state"]=state;
  await HttpUtils.post("Account/AccountBill", data).then((data){
    var getBillResponse = GetBillResponse.fromJson(data);
     switch(getBillResponse.statusCode){
       case 200:
         /*充值*/
        if(getBillResponse.data.item1&&getBillResponse.data.item2.count!="0"&&state=="1"){
          setState(() {
            list_recharge.addAll(getBillResponse.data.item2.data);
          });
        }
        /*提现*/
        if(getBillResponse.data.item1&&getBillResponse.data.item2.count!="0"&&state=="3"){
          setState(() {
            list_withdraw.addAll(getBillResponse.data.item2.data);
          });
        }
        /*收入支出*/
        if(getBillResponse.data.item1&&getBillResponse.data.item2.count!="0"&&state=="2,5"){
          setState(() {
            list_sz.addAll(getBillResponse.data.item2.data);
          });
        }
         break;
     }
  });
  }

  /*获取金额
  * "Account/GetUserInfoList"
  * */
  _getuserinfolist(String UserID,{String limit="1"}) async{
   var data=Map();
   data["UserID"]=UserID;
   data["limit"]=limit;
   await HttpUtils.post("Account/GetUserInfoList", data).then((data){
     var infoResult = InfoResult.fromJson(data);
     switch(infoResult.statusCode){
       case 200:
         if(infoResult.data.count!=0){
           setState(() {
            _totle= infoResult.data.data[0].totalMoney.toString();
            _canwithdraw=(infoResult.data.data[0].totalMoney-infoResult.data.data[0].frozenMoney).toString();
            _unfinished=infoResult.data.data[0].frozenMoney.toString();
            _freeze=infoResult.data.data[0].frozenMoney.toString();
            _con=infoResult.data.data[0].con.toString();

           });
         }
         break;
     }
   });
  }
  
  /*获取银行卡*/
  _getMyBankCard(String UserID) async{
    var data=Map();
    data["UserID"]=UserID;
    await HttpUtils.post("Account/GetAccountPayInfoList", data).then((data){
      var getBankCardResponse = GetBankCardResponse.fromJson(data);
      switch(getBankCardResponse.statusCode){
        case 200:
          if(getBankCardResponse.data.length!=0){
          setState(() {
            _bankcardnum="已绑定 ${getBankCardResponse.data.length} 张银行卡";
          });

          }
          
          break;
      }
    });
  }



}
