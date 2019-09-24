import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/http/http_utils.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_app_zhkj_master/bean/get_notifucation_response_entity.dart' as notifucation;

class MyNotifucationListPage extends StatefulWidget{
  final String type;
  MyNotifucationListPage({this.type});

  @override
  State<StatefulWidget> createState() {
    return _MyNotifucationListPage();
  }
}

class _MyNotifucationListPage extends State<MyNotifucationListPage>{
  
  List<notifucation.GetNotifucationResponseDataData> _list=List();
  String _title="";
  @override
  void initState() {
    super.initState();
    switch(widget.type){
      case "7":
        _title="系统消息";
        break;
      case "8":
        _title="平台政策";
        break;
      case "9":
        _title="平台新闻";
        break;
      case "10":
        _title="接单必读";
        break;
    }
    _GetListCategoryContentByCategoryID(widget.type);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        title: Text(_title,
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
      body: ListView.builder(
          itemCount: _list.length==0?0:_list.length,
          itemBuilder:(context,index){
            return

              GestureDetector(
                child:Container(
                  margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      Expanded(flex:1,child:Image.asset(ImageHelper.wrapAssets("read.png"),width: 20,height: 20)),
                      Expanded(flex:8,child:Text(_list[index].title)),
                      Expanded(flex:1,child:Image.asset(ImageHelper.wrapAssets("right_arrow.png"),width: 20,height: 20)),
                    ],
                  ),
                ),
                onTap: (){

                 NavigatorUtil.goWebPage(
                     context,
                     _list[index].url.replaceRange(0, 4, "https"),
                     _list[index].title
                 );
                },
              );

          }),
    );
  }



  /*
  *  /**
     * 获取文章列表
     * 师傅端
     * 7系统消息 8平台政策 9平台新闻 10接单必读
     *
     * @param CategoryID 栏目id
     * @return
     */
    @FormUrlEncoded
    @POST("Cms/GetListCategoryContentByCategoryID")
    Observable<BaseResult<Article>> GetListCategoryContentByCategoryID(
            @Field("CategoryID") String CategoryID,
            @Field("page") String page,
            @Field("limit") String limit

    );
  *
  *
  * */
  _GetListCategoryContentByCategoryID(String CategoryID,{String page="1",String limit="999"})async{
    var data=Map();
    data["CategoryID"]=CategoryID;
    data["page"]=page;
    data["limit"]=limit;
    await HttpUtils.post("Cms/GetListCategoryContentByCategoryID", data).then((result){
      var getNotifucationResponseEntity = notifucation.GetNotifucationResponseEntity.fromJson(result);
      switch(getNotifucationResponseEntity.statusCode){
        case 200:
          if(getNotifucationResponseEntity.data.count!="0"){
            setState(() {
              _list=getNotifucationResponseEntity.data.data;
            });
          }
          break;
      }

    });

  }


}