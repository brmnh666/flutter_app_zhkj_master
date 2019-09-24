
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alipay/flutter_alipay.dart';
import 'package:flutter_app_zhkj_master/bean/base_response.dart';
import 'package:flutter_app_zhkj_master/bean/get_wechat_pay_response.dart';
import 'package:flutter_app_zhkj_master/bean/info_result.dart';
import 'package:flutter_app_zhkj_master/config/eventconfig.dart';
import 'package:flutter_app_zhkj_master/eventbus/global_eventbus.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/http/http_utils.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_app_zhkj_master/provider/sp_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

/*充值页面*/
class RechargePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _RechargePage();
  }
}
class _RechargePage extends State<RechargePage>{
  int _index_selectmoney=0;
  int _index_paytype=0;
  String _totle="0.00";
  String _recharge_money="100";
  String _OutTradeNo="";//人工回调微信充值

  TextEditingController _controller=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*注册*/
    fluwx.register(appId:"wx827def61a5191c5d");
    /*支付回调*/
    fluwx.responseFromPayment.listen((response){

      switch(response.errCode){
        case 0://充值成功
          _WXNotifyManual(_OutTradeNo);
          break;
        case -2://退回
          break;
      }
      print("type的结果为 ${response.type} errStr的结果为${response.errStr} errCode的结果为${response.errCode}");
      //do something
    });


    SpHelper.getUserName().then((username)=> _getuserinfolist(username));
    _controller.addListener((){
     setState(() {
       _recharge_money=_controller.text;
     });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,240,240,240),
      appBar:  AppBar(
        title: Text("余额充值",
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
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              /*余额显示*/
              Container(
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                height: 70,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                 color: Colors.white,
                  border: Border(top: BorderSide(width: 0.3,color: Colors.grey),
                        bottom: BorderSide(width: 0.3,color: Colors.grey))
                ),
               child: 
               Row(
                 children: <Widget>[
                   Padding(
                     padding: EdgeInsets.only(left: 10),
                     child: Image.asset(ImageHelper.wrapAssets("ic_yuer.png"),width: 42,height: 42)),
                   Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Padding(
                           padding: EdgeInsets.only(bottom: 4,left: 10),
                           child:  Text("账户余额:",style: TextStyle(fontSize: 13,color: Colors.grey,fontWeight:FontWeight.w500))),
                         Padding(padding:EdgeInsets.only(top:3,left: 10),
                           child: Text(_totle) ,
                         )

                       ]),
                 ],
               )
              ),

              /*选择充值金额*/
              Container(
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(width: 0.3,color: Colors.grey))
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                     padding: EdgeInsets.only(left: 10,top: 15),
                     alignment: Alignment.centerLeft,
                     child: Text("请选择充值金额",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))
                    ),
                       Container(
                         margin:EdgeInsets.only(top: 10),
                         padding: EdgeInsets.only(left: 10,right: 10),
                         child:GridView.count(
                           physics: NeverScrollableScrollPhysics(),
                           padding: EdgeInsets.all(5.0),
                           //一行多少个
                           crossAxisCount: 3,
                           //滚动方向
                           scrollDirection: Axis.vertical,
                           //左右间隔
                           crossAxisSpacing: 8.0,
                           //上下间隔
                           mainAxisSpacing: 8.0,
                           //宽高比
                           childAspectRatio: 1/0.45,
                           shrinkWrap: true,
                           children: <Widget>[
                             selectmoney_item(0,"100"),
                             selectmoney_item(1,"300"),
                             selectmoney_item(2,"500"),
                             selectmoney_item(3,"1,000"),
                             selectmoney_item(4,"2,000"),
                             selectmoney_item(5,"3,000"),
                             selectmoney_item(6,"其他"),
                           ],
                         ),
                       ),
                    /*支付方式*/
                    Container(
                        padding: EdgeInsets.only(left: 10,top: 15),
                        alignment: Alignment.centerLeft,
                        child: Text("支付方式",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))
                    ),

                    Container(
                      margin:EdgeInsets.only(top: 10),
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child:GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(5.0),
                        //一行多少个
                        crossAxisCount: 3,
                        //滚动方向
                        scrollDirection: Axis.vertical,
                        //左右间隔
                        crossAxisSpacing: 8.0,
                        //上下间隔
                        mainAxisSpacing: 8.0,
                        //宽高比
                        childAspectRatio: 1/0.55,
                        shrinkWrap: true,
                        children: <Widget>[
                          selectpaytype_item(0,"支付宝","ic_zhifubao.png"),
                          selectpaytype_item(1,"微信","ic_wechat.png"),
                        ],
                      ),
                    ),
                    /*阅读协议*/
                    Container(
                      margin: EdgeInsets.only(top: 60),
                      child:
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                              Text("同意并阅读", style:TextStyle(fontSize: 14,color: Colors.black)),
                              GestureDetector(
                                child: Text("《充值服务协议》",style:TextStyle(color:Colors.blue,fontSize: 14,fontWeight: FontWeight.w600)),
                                onTap: (){
                                  NavigatorUtil.goWebPage(context,
                                      "https://admin.xigyu.com/Agreement",
                                      "充值协议");
                                },
                              )

                            ],
                            ),
                          ),

                    ),

                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255,22,144,255),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child:
                        RichText(
                          text: TextSpan(
                              text: "立即充值",
                              style:TextStyle(fontSize: 15,color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: " (¥${_recharge_money})",
                                  style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w500),
                                )
                              ]
                          ),
                        ) ,

                      ),
                      onTap: (){
                        if(_index_paytype==0){//支付宝支付
                          if(_recharge_money==""){
                            Fluttertoast.showToast(msg: "请输入充值金额");
                            return;
                          }else{
                            SpHelper.getUserName().then((username)=>
                                _GetOrderStr(username,
                                    _recharge_money.replaceAll(",", ""))
                            );
                          }
                        }else if(_index_paytype==1){//微信支付
                        //  Fluttertoast.showToast(msg: "暂不支持微信支付");
                          if(_recharge_money==""){
                            Fluttertoast.showToast(msg: "请输入充值金额");
                            return;
                          }else{
                            SpHelper.getUserName().then((username)=>
                            _GetWXOrderStr(username, _recharge_money)
                            );
                          }


                       }
                    },
                    )
                  ],
                ),
              ),



        ]
        ),
      ),

    );
  }
  /*选择金额每个item*/
  Widget selectmoney_item(position,title) {
    return _index_selectmoney==position ? //选中情况
    GestureDetector(
      child:
          Stack(children: <Widget>[
            /*显示下角标*/
            Container(
              alignment: Alignment.bottomRight,
              child:  Image.asset(ImageHelper.wrapAssets("ic_jiaobiao.png"),width: 20,height: 20),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color.fromARGB(60,22,144,255),
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: Color.fromARGB(255,22,144,255),width: 0.7)
              ),
              child: position==6?
              Row(children: <Widget>[
                Expanded(child:
                Padding(padding: EdgeInsets.only(left: 10,right: 5),
                  child:TextField(
                    controller: _controller,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5,bottom: 5),
                      disabledBorder: InputBorder.none,
                      enabledBorder:  InputBorder.none,
                      focusedBorder:   InputBorder.none,
                    ),
                    //光标设置
                    cursorColor: Colors.black,
                    cursorWidth: 1,
                    keyboardType: TextInputType.number,
                  ),
                )
                ),
                Padding(padding: EdgeInsets.only(right: 10),
                  child:Text("元"),)
              ]): Text(title,style: TextStyle(color: Colors.black,fontSize: 13)
              ),
            ),
          ]
          ),
      onTap: (){
        setState(() {
          if(position==6){
            _recharge_money="";
            _controller.text="";
          }else{
            _recharge_money=title;
          }
          _index_selectmoney=position;
        });

      },
    )
     :GestureDetector(//未选中情况
      child:
      Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(7)),
            border: Border.all(color: Colors.grey,width: 0.7)
        ),
        child: Text(title,style: TextStyle(color: Colors.grey,fontSize: 13)),
      ),
      onTap: (){
        setState(() {
          if(position==6){
            _recharge_money="";
            _controller.text="";
          }else{
            _recharge_money=title;
          }
          _index_selectmoney=position;
        });
      },
    );
  }


/*选择支付方式每个item*/
  Widget selectpaytype_item(position,title,url) {
    return _index_paytype==position ? //选中情况
    GestureDetector(
      child:
        Stack(children: <Widget>[
          /*显示下角标*/
          Container(
            alignment: Alignment.bottomRight,
            child:  Image.asset(ImageHelper.wrapAssets("ic_jiaobiao.png"),width: 20,height: 20),
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color.fromARGB(60,22,144,255),
                borderRadius: BorderRadius.all(Radius.circular(7)),
                border: Border.all(color: Color.fromARGB(255,22,144,255),width: 0.7)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(ImageHelper.wrapAssets(url),width: 26,height: 26),
                Text(title,style: TextStyle(color: Colors.black,fontSize: 12)),
              ],
            ),
          ),
        ],
        ),
      onTap: (){
        setState(() {
          _index_paytype=position;
        });
      },
    )
        :GestureDetector(//未选中情况
          child:
          Container(
           alignment: Alignment.center,
           decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(7)),
            border: Border.all(color: Colors.grey,width: 0.7)
        ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(ImageHelper.wrapAssets(url),width: 26,height: 26),
                Text(title,style: TextStyle(color: Colors.black,fontSize: 12)),
              ],
            ),
      ),
      onTap: (){
        setState(() {
          _index_paytype=position;
        });
      },
    );
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
            });
          }
          break;
      }
    });
  }


  /*支付宝获取充值信息*/
  _GetOrderStr(
      String UserID,
      String TotalAmount,
      {String BisId="",String OrderId="",String Type="1",String json=""}
      ) async{
      var data=Map();
      data["UserID"]=UserID;
      data["TotalAmount"]=TotalAmount;
      data["BisId"]=BisId;
      data["OrderId"]=OrderId;
      data["Type"]=Type;
      data["json"]=json;
      
      await HttpUtils.post("Pay/GetOrderStr", data).then((data){
        var baseResponse = BaseResponse.fromJson(data);
        switch(baseResponse.statusCode){
          case 200:
            if(baseResponse.data.item1){
              _alipay(baseResponse.data.item2);
            }
            break;
        }
      });
   }

    /*alipay*/
   _alipay(String payinfo)async{
    await FlutterAlipay.pay(payinfo).then((alipay){
      switch(alipay.resultStatus){
        case "9000":
          Fluttertoast.showToast(msg: "订单支付成功");
          GlobalEventBus().eventBus.fire(StateChangeEvent(EventConfig.MONENY));
          NavigatorUtil.goBack(context);
          break;
        case "8000":
          Fluttertoast.showToast(msg: "正在处理中");
          break;
        case "4000":
          Fluttertoast.showToast(msg: "订单支付失败");
          break;
        case "5000":
          Fluttertoast.showToast(msg: "重复请求");
          break;
        case "6002":
          Fluttertoast.showToast(msg: "网络连接出错");
          break;
        case "6001":
          Fluttertoast.showToast(msg: "用户中途取消");
      }
    });
   }


/*
*  @POST("Pay/GetWXOrderStr")
    Observable<BaseResult<Data<WXpayInfo>>> GetWXOrderStr(@Field("UserID") String UserID,
                                                          @Field("BisId") String BisId,
                                                          @Field("OrderId") String OrderId,
                                                          @Field("TotalAmount") String TotalAmount,
                                                          @Field("Type") String Type,
                                                          @Field("Style") String Style,
                                                          @Field("JsonStr") JSONArray JsonStr);
                                                          *
* {StatusCode: 200, Info: 请求(或处理)成功, Data: {Item1: true, Item2: {appid: wxe6645eb8d10e5f9d,
* noncestr: hSdlMktU3Poxyt99,
* out_trade_no: 2443-1568864036496294496294,
* package: Sign=WXPay, partnerid: 1527134641,
*  prepayid: wx19113356385369d1f8ba95e51492094500,
* sign: EAD7605B1E847F6B56116B470BBFE080,
* timestamp: 1568864036}}}
* */

  /*微信获取充值信息*/
_GetWXOrderStr(String UserID,
      String TotalAmount,
     {String BisId="",
     String OrderId="",
     String Type="1",
     String Style="fluttermaster",
     String json=""}
    ) async{
  var data = Map();
  data["UserID"]=UserID;
  data["TotalAmount"]=TotalAmount;
  data["BisId"]=BisId;
  data["OrderId"]=OrderId;
  data["Type"]=Type;
  data["Style"]=Style;
  data["json"]=json;
  await HttpUtils.post("Pay/GetWXOrderStr", data).then((data){
     var getWechatPayResponse = GetWechatPayResponse.fromJson(data);
     switch(getWechatPayResponse.statusCode){
       case 200:
         if(getWechatPayResponse.data.item1){
           _OutTradeNo= getWechatPayResponse.data.item2.outTradeNo;
           _wechatpay(
               getWechatPayResponse.data.item2.appid,
               getWechatPayResponse.data.item2.partnerid,
               getWechatPayResponse.data.item2.prepayid,
               getWechatPayResponse.data.item2.package,
               getWechatPayResponse.data.item2.noncestr,
               int.parse(getWechatPayResponse.data.item2.timestamp),
               getWechatPayResponse.data.item2.sign,
           );
         }else{
           Fluttertoast.showToast(msg: "支付出错");
         }
         break;

     }

  });
}


_wechatpay(appId,partnerId,prepayId,packageValue,
     nonceStr,timeStamp,sign,{signType, extData}){
      fluwx.pay(
      appId: appId,
      partnerId: partnerId,
      prepayId: prepayId,
      packageValue: packageValue,
      nonceStr: nonceStr,
      timeStamp: timeStamp,
      sign: sign).then((wx){
      print(wx["platform"]);
      print(wx["result"]);
  });
}

/*
*  /**
     * 微信人工回调OutTradeNo
     *
     * @param OutTradeNo
     * @return
     */
    @FormUrlEncoded
    @POST("Pay/WXNotifyManual")
    Observable<BaseResult<Data<String>>> WXNotifyManual(@Field("OutTradeNo") String OutTradeNo);
* */
  _WXNotifyManual(String out_trade_no)async{
    var data=Map();
    data["out_trade_no"]=out_trade_no;
    await HttpUtils.post("Pay/WXNotifyManual", data).then((response){
      var baseResponse = BaseResponse.fromJson(response);
      switch(baseResponse.statusCode){
        case 200:
          if(baseResponse.data.item1){
            GlobalEventBus().eventBus.fire(StateChangeEvent(EventConfig.MONENY));
            NavigatorUtil.goBack(context);
          }
          break;
       }
      }
    );


  }


}