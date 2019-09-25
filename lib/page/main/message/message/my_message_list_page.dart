import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/bean/base_response.dart';
import 'package:flutter_app_zhkj_master/bean/get_message_response_entity.dart' as message;
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/http/http_utils.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_app_zhkj_master/provider/index.dart';
import 'package:flutter_app_zhkj_master/provider/model/ConfigModel.dart';
import 'package:flutter_app_zhkj_master/provider/sp_helper.dart';
import 'package:flutter_app_zhkj_master/provider/theme_util.dart';
import 'package:flutter_app_zhkj_master/util/my_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyMessageListPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyMessageListPage();
  }
}
class _MyMessageListPage extends State<MyMessageListPage> {

  /*未读消息*/
  List<message.GetMessageResponseDataData> _list=List();

  /*已读消息*/
  List<message.GetMessageResponseDataData> _readedlist=List();
  @override
  void initState() {
    super.initState();
     SpHelper.getUserName().then((username){
       _GetListmessageByType(username);
       _GetReadListmessageByType(username);
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        title: Text("工单消息",
          style: TextStyle(
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
        child: Column(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Text(" 你有${_list.length}条新消息 "),
                  )

                ]),
            Container(
              height: _getContainhight(_list.length),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _list.length==0?0:_list.length,
                  itemBuilder: (context, index) {
                    return
                      GestureDetector(
                        child: Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            height: 90,
                            child: Card(
                              child: Row(
                                children: <Widget>[
                                  Expanded(flex: 1, child:
                                  Image.asset(
                                    ImageHelper.wrapAssets("ic_messgongdang.png"),
                                    width: 42, height: 42,),

                                  ),
                                  Expanded(flex: 3,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 8, bottom: 8, right: 8),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            border: Border.all(
                                                color: Colors.grey, width: 0.5),
                                            // color: Color.fromARGB(50, 198,198,198)
                                            color: Color.fromARGB(50, 71, 104, 243)
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.only(bottom: 5),
                                                child: Text("${_list[index].content}",
                                                    style: TextStyle(
                                                        fontSize: 14))),
                                            Padding(
                                                padding: EdgeInsets.only(top: 5),
                                                child: Text(MyUtil.getTimeforCN(_list[index].nowtime),
                                                    style: TextStyle(fontSize: 10,
                                                        color: Colors.grey)))
                                          ],
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            )
                        ),
                         onTap: (){
                          _AddOrUpdatemessage(_list[index].messageID.toString(), index, _list[index]);
                      }
                      );


                  }
              ),
            ),

            /*已读*/
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Text(" 以下是已读消息 "),
                  )

                ]),
            Container(
              height: _getContainhight(_readedlist.length),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _readedlist.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        child:  Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            height: 90,
                            child: Card(
                              child: Row(
                                children: <Widget>[
                                  Expanded(flex: 1, child:
                                  Image.asset(
                                    ImageHelper.wrapAssets("ic_messgongdang.png"),
                                    width: 42, height: 42,),

                                  ),
                                  Expanded(flex: 3,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 8, bottom: 8, right: 8),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            border: Border.all(
                                                color: Colors.grey, width: 0.5),
                                            // color: Color.fromARGB(50, 198,198,198)
                                            color: Color.fromARGB(50, 238, 99, 99)
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.only(bottom: 5),
                                                child: Text("${_readedlist[index].content}",
                                                    style: TextStyle(
                                                        fontSize: 14))),
                                            Padding(
                                                padding: EdgeInsets.only(top: 5),
                                                child: Text(MyUtil.getTimeforCN(_readedlist[index].nowtime),
                                                    style: TextStyle(fontSize: 10,
                                                        color: Colors.grey)))
                                               ],
                                             ),
                                           )
                                       ),
                                     ],
                                   ),
                                 )
                             ),
                             onTap: (){
                          Fluttertoast.showToast(msg: "点击了已读信息");

                         },
                      );

                  }
              ),
            )
          ],
        ),
      ),
    );
  }

  _getContainhight(int count){
    if (count==0){
      return 0.0;
    }else{
      return count*90.0;
    }

  }


  /*
  获取消息列表
  type=2  subtype=0  limit=999 page=1
  islock=1未读 islock=2 已读
  "Cms/GetListmessageByType"
   */
  _GetListmessageByType(String UserID,
      {String Type = "2",
        String SubType = "0",
        String limit = "999",
        String page = "1",
        String IsLook = "1"
      }) async {
    var data = Map();
    data["UserID"] = UserID;
    data["Type"] = Type;
    data["SubType"] = SubType;
    data["limit"] = limit;
    data["page"] = page;
    data["IsLook"] = IsLook;
    await HttpUtils.post("Cms/GetListmessageByType", data).then((result){
      var getMessageResponseEntity = message.GetMessageResponseEntity.fromJson(result);
      switch(getMessageResponseEntity.statusCode){
        case 200:
          setState(() {
            _list=getMessageResponseEntity.data.data;
          });
          break;
      }
    });
  }
  _GetReadListmessageByType(String UserID,
      {String Type = "2",
        String SubType = "0",
        String limit = "999",
        String page = "1",
        String IsLook = "2"
      }) async {
       var data = Map();
       data["UserID"] = UserID;
       data["Type"] = Type;
       data["SubType"] = SubType;
       data["limit"] = limit;
       data["page"] = page;
       data["IsLook"] = IsLook;
       await HttpUtils.post("Cms/GetListmessageByType", data).then((result){
        var getMessageResponseEntity = message.GetMessageResponseEntity.fromJson(result);
        switch(getMessageResponseEntity.statusCode){
        case 200:
          setState(() {
            _readedlist=getMessageResponseEntity.data.data;
          });
          break;
      }
    });
  }

  /*更新信息状态
  "Cms/AddOrUpdatemessage"
  {"StatusCode":200,"Info":"请求(或处理)成功","Data":{"Item1":true,"Item2":""}}
  */
_AddOrUpdatemessage(String MessageID,int position,message.GetMessageResponseDataData message,{String IsLook}) async {
  var data=Map();
  data["MessageID"]=MessageID;
  data["IsLook"]="2";
  await HttpUtils.post("Cms/AddOrUpdatemessage", data).then((result){
    var baseResponse = BaseResponse.fromJson(result);
    switch(baseResponse.statusCode){
      case 200:
        if(baseResponse.data.item1){
          Fluttertoast.showToast(msg: "点击了messageid为${MessageID}的消息");
          setState(() {
            _list.removeAt(position);
            _readedlist.add(message);
          });
        }
        break;
    }

  });
  
}



}