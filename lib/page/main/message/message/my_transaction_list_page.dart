import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/http/http_utils.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';

import 'package:flutter_app_zhkj_master/bean/get_message_response_entity.dart' as message;
import 'package:flutter_app_zhkj_master/provider/sp_helper.dart';
import 'package:flutter_app_zhkj_master/util/my_util.dart';
class MyTransactionListPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyTransactionListPage();
  }
}
class _MyTransactionListPage extends State<MyTransactionListPage>{
  List<message.GetMessageResponseDataData> _list=List();

  @override
  void initState() {
    super.initState();
    SpHelper.getUserName().then((username)=>_GetListmessageByType(username));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        title: Text("交易信息(共${_list.length}条)",
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
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.cyan,
                    Colors.blue,
                    Colors.blueAccent,
                    Colors.blue,
                    Colors.cyan
                  ]
              )
          ),
        ),
        elevation: 0.0,
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: _list.length==0?0.0:_list.length*90.0,
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
                                      ImageHelper.wrapAssets("ic_jiaoyi.png"),
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
                                              color: Color.fromARGB(50, 247,210,127)
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

                          }
                      );

                  }
              ),
            ),
          ],

        ),
      ),

    );
  }


  /*
  获取消息列表
  type=2  subtype=0  limit=999 page=1
  islock=1未读 islock=2 已读
  "Cms/GetListmessageByType"
   */
  _GetListmessageByType(String UserID,
      {String Type = "1",
        String SubType = "0",
        String limit = "999",
        String page = "1",
        String IsLook = ""
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

}