import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/bean/get_bank_card_response.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/http/http_utils.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_app_zhkj_master/provider/sp_helper.dart';
import 'package:flutter_app_zhkj_master/util/my_util.dart';

/*选择银行卡页面*/
class SelectBankPage extends StatefulWidget{
  final String index;
  SelectBankPage({this.index});

  @override
  State<StatefulWidget> createState() {
    return _SelectBankPage();
  }
}
class _SelectBankPage extends State<SelectBankPage>{
  List<Data> _Listbank = List();
  @override
  void initState() {
    super.initState();
    /*获取传来的index*/

    SpHelper.getUserName().then((username)=>_getMyBankCard(username));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,240,240,240),
      appBar: AppBar(
        title: Text("选择银行卡",
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
      body: Container(
               margin:EdgeInsets.only(top: 15) ,
               child: ListView.separated(
                 itemCount: _Listbank==0?0:_Listbank.length,
                 separatorBuilder: (BuildContext context, int index){
                   return Divider(color: Colors.grey,height: 0.3,);
                 },
                 itemBuilder: (BuildContext context,int index){
                  return
                    GestureDetector(
                      child: Container(
                        color: Colors.white,
                        height: 50,
                        child:
                        Row(
                          children: <Widget>[
                            /*银行图片*/
                            Expanded(
                                flex: 1,
                                child:
                                Image.asset(
                                    ImageHelper.wrapAssets(MyUtil.showBankLogo(_Listbank[index].payInfoName)),width: 32,height: 32)
                            ),
                            /*银行信息*/
                            Expanded(
                                flex: 4,
                                child:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(_Listbank[index].payInfoName,style: TextStyle(fontSize: 16,color: Colors.black)),
                                    Padding(padding: EdgeInsets.only(top: 4),
                                        child: Text("尾号${_Listbank[index].payNo.substring(_Listbank[index].payNo.length-4)}",style: TextStyle(fontSize: 11,color: Colors.grey)))

                                  ],)
                            ),
                            /*选择按钮*/
                            Expanded(
                                flex: 1,
                                child:
                                Offstage(
                                  offstage: widget.index==index.toString()?false:true,
                                  child:
                                  Image.asset(ImageHelper.wrapAssets("ic_chooes.png"),width: 23,height: 23),
                                )
                            )
                          ],
                        ),

                      ) ,
                      onTap: (){

                        NavigatorUtil.goBackWithParams(context,index);
                      },
                    );

             })
           ),


    );
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
         print(getBankCardResponse.data[0].isSelect);
         setState(() {
           _Listbank=getBankCardResponse.data;
         });
         break;
     }
  });
 }

}