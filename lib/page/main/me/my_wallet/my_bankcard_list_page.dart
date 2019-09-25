import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/bean/get_bank_card_response.dart';
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
  void initState() {
    super.initState();
    SpHelper.getUserName().then((username)=>_getMyBankCard(username));
    /*需要更新数据操作*/
    GlobalEventBus().eventBus.on<StateChangeEvent>().listen((event){
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
        flexibleSpace: Store.connect<ConfigModel>(
            builder: (context, ConfigModel snapshot, child) {
              return
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: ThemeUtil.setActionBar(snapshot.theme)
                      )
                  ),
                );
            }
        ),


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
                       color: MyUtil.BackGroundColor(
                           _Listbank[index].payInfoName
                       ),
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
                             ImageHelper.wrapAssets(MyUtil.showBankLogo(
                                 _Listbank[index].payInfoName
                             ))
                           ),
                         ),
                         /*银行名*/
                         Container(
                           margin: EdgeInsets.only(left: 70,top: 20),
                           child:
                           Text(
                             _Listbank[index].payInfoName,style: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.w500)
                           ),
                         ),

                         /*卡号*/
                         Container(
                           margin: EdgeInsets.only(bottom: 15,right: 10),
                           alignment: Alignment.bottomRight,
                           child:
                           Text(
                             "${_Listbank[index].payNo.substring(0,4)} **** **** ${_Listbank[index].payNo.substring(_Listbank[index].payNo.length-4,_Listbank[index].payNo.length)}"
                             ,style: TextStyle(color: Colors.white,fontSize:15)
                           )
                         )

                       ],
                       ),
                     ),
                   );
                 }
             ),),

            /*添加银行卡*/
            GestureDetector(
              child: Store.connect<ConfigModel>(
                  builder: (context, ConfigModel snapshot, child) {
                    return   Container(
                      height: 60,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 20,left: 13,right: 13),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color:ThemeUtil.SetFontColor(snapshot.theme)
                              ,width: 1)
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(left: 10,right: 10),child: Image.asset(ImageHelper.wrapAssets("tianjia1.png"),width: 30,height: 30)),
                          Expanded(child:Text("添加银行卡",style: TextStyle(fontSize: 18))),
                          Padding(padding: EdgeInsets.only(right: 5),child:Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 20,height: 20) ,)
                        ],
                      ),
                    );
                  }
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


  /*获取我的银行卡*/
  //"Account/GetAccountPayInfoList"
  _getMyBankCard(String UserID) async{
    var data=Map();
    data["UserID"]=UserID;
    await HttpUtils.post("Account/GetAccountPayInfoList", data).then((data){
      var getBankCardResponse = GetBankCardResponse.fromJson(data);
      switch(getBankCardResponse.statusCode){
        case 200:
          setState((){
            _Listbank=getBankCardResponse.data;
          });
          break;
      }
    });
  }




}