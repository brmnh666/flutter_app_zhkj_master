
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/bean/base_response.dart';
import 'package:flutter_app_zhkj_master/bean/get_work_response.dart';
import 'package:flutter_app_zhkj_master/bean/info_result.dart';
import 'package:flutter_app_zhkj_master/config/config.dart';
import 'package:flutter_app_zhkj_master/eventbus/global_eventbus.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/http/http_utils.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_app_zhkj_master/provider/index.dart';
import 'package:flutter_app_zhkj_master/provider/model/ConfigModel.dart';
import 'package:flutter_app_zhkj_master/provider/model/UserModel.dart';
import 'package:flutter_app_zhkj_master/provider/sp_helper.dart';
import 'package:flutter_app_zhkj_master/provider/theme_util.dart';
import 'package:flutter_app_zhkj_master/util/my_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class MyHomeItemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomeItemPage();
  }
}
class _MyHomeItemPage extends State<MyHomeItemPage>{
  List<Data2> list_work=List();//工单列表
  int page=1;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState(){
    super.initState();
      SpHelper.getUserName().then(
       (UserName){
         _getWorkInfo(UserName,"0","1","10");
       }
      );

  }


  @override
  void dispose() {
    super.dispose();
    GlobalEventBus().eventBus.destroy();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromARGB(255,240,240,240),
      body:
          Column(children: <Widget>[
            Stack(
              children: <Widget>[
                /*顶部 显示*/
                Store.connect<ConfigModel>(
                    builder: (context, ConfigModel snapshot, child) {
                      return Container(
                        width: double.infinity,
                        height: 170,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: ThemeUtil.setActionBar(snapshot.theme)
                            )
                        ),
                      );
                    }
                ),


                /*首页 分享商城  客服*/
                Container(
                    margin: EdgeInsets.only(top: 35),
                    child:Row(children: <Widget>[
                      /*分享商城*/
                      Container(
                        margin: EdgeInsets.only(left: 25),
                        child: Column(
                          children: <Widget>[
                            Image.asset(ImageHelper.wrapAssets("icon_qr_code.png"),width: 20,height: 20),
                            Text("分享商城",style: TextStyle(color: Colors.white,fontSize: 10)),
                          ],
                        )
                      ),

                      /*首页*/
                      Container(
                        child: Expanded(
                          child:Center(
                              child:Text("首页",style: TextStyle(color: Colors.white,fontSize: 20))
                        )
                        )

                      ),

                      /*客服*/
                      Container(
                        margin: EdgeInsets.only(left:15,right: 25),
                        child:Column(
                          children: <Widget>[
                            Image.asset(ImageHelper.wrapAssets("icon_customer_services.png"),width: 20,height: 20),
                            Text("客服",style: TextStyle(color: Colors.white,fontSize: 10)),
                          ],
                        ),
                      )
                    ],
                    )
                ),

                /*实时新工单*/
                Container(
                  color: Colors.white,
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top:170),
                  height: 97,
                  child:Row(
                    children: <Widget>[
                      /*实时新订单*/
                     Expanded(
                        child:
                        Padding(padding: EdgeInsets.only(bottom: 10),
                         child:    Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(ImageHelper.wrapAssets("icon_home_sheet.png"),width: 23,height: 23,),
                            Text("实时新订单",style: TextStyle(fontSize: 17),)
                          ],
                          )
                         ),
                        flex: 1,
                      ),

                      /*点击刷新新工单*/

                   Expanded(
                         child:
                         Padding(padding: EdgeInsets.only(bottom: 10),
                             child:Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[
                                 Image.asset(ImageHelper.wrapAssets("shou_red.png"),width: 27,height: 27,),
                                 Text("点击刷新工单",style: TextStyle(fontSize: 17),)
                          ],
                          )
                         ),
                        flex: 1,
                      ),

                    ],
                  ) ,
                ),




                /*个人信息卡片*/
                  Container(
                  width: double.infinity,
                  height: 145,
                  margin: EdgeInsets.only(top: 80,left: 5,right:5),
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            /*头像显示*/
                             Container(
                               margin: EdgeInsets.only(left: 20),
                               child:ClipRRect(
                                   borderRadius: BorderRadius.circular(40),
                                   child:
                                   Store.connect<UserModel>(
                                       builder: (context, UserModel snapshot, child) {
                                         return Image.network(
                                           Config.HEAD_URL+"${snapshot.avator}",
                                           width: 80,
                                           height: 80,
                                           fit: BoxFit.fill, //图片填充方式
                                         );
                                       }
                                   ),

                               ),
                             ),

                            /*右侧店铺名，是否实名认证 西瓜币数量显示*/
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                /*店铺名*/
                                Container(
                                   margin: EdgeInsets.only(left: 10,bottom: 5),
                                   child:
                                   Store.connect<UserModel>(
                                       builder: (context, UserModel snapshot, child) {
                                         return Text(
                                          '${snapshot.nickname}',
                                            softWrap: true,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)
                                         );
                                       }
                                   ),
                                  ),
                               /*已实名认证*/
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Offstage(
                                    offstage:  Store.value<UserModel>(context).ifauth!="1",
                                    child:
                                    /*是否实名认证*/
                                    Row(
                                        children: <Widget>[
                                          Image.asset(ImageHelper.wrapAssets("home_yishiming.png"),width: 15,height: 15,),
                                          Text("已实名认证",style: TextStyle(fontSize: 13,color: Colors.blueAccent),),
                                        ]
                                    ),
                                  ),
                                ),
                                /*审核中*/
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Offstage(
                                    offstage:Store.value<UserModel>(context).ifauth!="0",
                                    child:
                                    Row(
                                        children: <Widget>[
                                          Image.asset(ImageHelper.wrapAssets("home_yishiming.png"),width: 15,height: 15,),
                                          Text("审核中",style: TextStyle(fontSize: 13,color: Colors.blueAccent),),
                                        ]
                                    ),
                                  ),
                                ),
                                /*审核拒绝*/
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Offstage(
                                    offstage:Store.value<UserModel>(context).ifauth!="-1",
                                    child:
                                    Row(
                                        children: <Widget>[
                                          Image.asset(ImageHelper.wrapAssets("home_yishiming.png"),width: 15,height: 15,),
                                          Text("审核拒绝",style: TextStyle(fontSize: 13,color: Colors.blueAccent),),
                                        ]
                                    ),
                                  ),
                                ),
                                /*未实名认证*/
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: GestureDetector(
                                    child: Offstage(
                                      offstage: Store.value<UserModel>(context).ifauth!=null,
                                      child: Row(
                                          children: <Widget>[
                                            Image.asset(ImageHelper.wrapAssets("all_weishiming.png"),width: 15,height: 15,),
                                            Text("未实名认证",style: TextStyle(fontSize: 13,color: Colors.red),),
                                          ]
                                      ),
                                    ),
                                    onTap:(){
                                      //Fluttertoast.showToast(msg: "点击了实名认证");
                                      NavigatorUtil.goCertificationPage(context);
                                    } ,
                                  ),
                                ),



//                               /*西瓜币余额*/
                                Container(
                                  margin: EdgeInsets.only(left: 10,top: 5),
                                    child:
                                    Store.connect<UserModel>(
                                        builder: (context, UserModel snapshot, child) {
                                          return Text(
                                              "西瓜币:¥ ${snapshot.con}",
                                              style: TextStyle(fontSize: 16,color: Color.fromARGB(255,125,125,125))
                                          );
                                        }
                                    ),


                                )

                              ],
                            )

                          ],

                        ),


                      ),
                    ),
                ) ,


              ],
            ),

             Expanded(
                 child:
                 //下拉刷新上拉加载组件
                 SmartRefresher(
                   controller: _refreshController,
                   enablePullDown: true,
                   enablePullUp: true,
                   header: MaterialClassicHeader(),
                   footer: ClassicFooter(),
                   onRefresh: _onRefresh,
                   onLoading: _onLoading,
                   child: //首先判断是否有无数据显示空布局页面
                   list_work.length==0?
                       Container(
                            color: Color.fromARGB(255,255,254,255),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                Image.asset(ImageHelper.wrapAssets("icon_order_empty.png"),width: 180,height: 140),
                                Text("暂无工单",style: TextStyle(fontSize: 10))
                              ],
                            ),     
                       ):
                       ListView.builder(
                           itemCount:  (list_work.length==0) ? 0 : list_work.length,
                           itemBuilder: (BuildContext context,int index){//item构造器
                             return Container(
                               margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                               decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.all(Radius.circular(5))
                               ),
                               child: Column(
                                 children: <Widget>[
                                   /*第一行*/
                                   Container(
                                     padding: EdgeInsets.only(left: 10,right: 10,top: 15),
                                     child:  Row(children: <Widget>[
                                       /*时间*/
                                       Text(MyUtil.getTimebefore(list_work[index].createDate),style: TextStyle(fontSize: 12)),
                                       /*工单类型安装维修*/
                                       Container(
                                         decoration: BoxDecoration(
                                             color: Color.fromARGB(255,255,0,0),
                                             borderRadius: BorderRadius.all(Radius.circular(2))
                                         ),
                                         padding: EdgeInsets.only(left: 4,right: 4,top: 1,bottom: 1),
                                         margin: EdgeInsets.only(left: 8),
                                         child: Text("${list_work[index].typeName}/${list_work[index].guarantee=='Y'?'保内':'保外'}",style: TextStyle(color:Colors.white,fontSize: 10)),
                                       ),
                                       /*距离*/
                                       Expanded(
                                           child:
                                           Container(
                                               alignment: Alignment.centerRight,
                                               child:Image.asset(ImageHelper.wrapAssets("icon_loaction.png"),width: 14,height: 14))),
                                       Text("距离:${list_work[index].distance}Km",style: TextStyle(fontSize: 12))
                                     ]
                                     ),
                                   ),

                                   /*第二行*/
                                   Row(children: <Widget>[
                                     /*安装维修物品和故障原因和地址*/
                                     Expanded(
                                         flex: 4,
                                         child:
                                         Column(
                                           children: <Widget>[
                                             /*物品名称*/
                                             Container(
                                               child:Text("${list_work[index].categoryName} ${list_work[index].brandName} ${list_work[index].subCategoryName}",
                                                   style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 55,55,55))),
                                               margin: EdgeInsets.only(left: 10,top: 10),
                                             ),
                                             /*故障原因*/

                                             Container(
                                               margin: EdgeInsets.only(left: 10,top: 10),
                                               child:  Text("故障:${list_work[index].memo}",style: TextStyle(fontSize: 16),),
                                             ),


                                             Container(
                                               margin: EdgeInsets.only(left: 10,top: 10,bottom: 15),
                                               child: Text("${list_work[index].address}",style: TextStyle(fontSize: 14)),

                                             )

                                           ],
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                         )

                                     ),
                                     /*接单按钮*/
                                     Expanded(
                                         flex: 1,
                                         child:
                                         GestureDetector(
                                           child:   Container(
                                               child: Image.asset(ImageHelper.wrapAssets("icon_home_grabsheet.png"),width: 51,height: 51,),
                                               margin: EdgeInsets.only(bottom: 10,right: 10)),
                                           onTap: (){//点击接单按钮
                                             _GrabSheet(list_work[index].orderID.toString(),index);
                                           },
                                         )
                                     ),
                                   ]
                                   ),
                                 ],
                               ),
                             );
                           }
                       ),

                 )



             )




          ],
          )

    );
  }

  /*下拉刷新*/
  void _onRefresh() async{
    list_work.clear();
    page=1;
    SpHelper.getUserName().then((UserName){
      _getWorkInfo(UserName,"0","1","10");
       _getInfo(UserName);
    }
       );
  }

  /*上拉加载*/
  void _onLoading() async{
    page++;
    SpHelper.getUserName().then((UserName) =>_getWorkInfo(UserName,"0",page.toString(),"10"));
  }


  /*更新个人信息*/
  _getInfo(String UserID ,{String limit="1"}) async{
    var map=Map();
    map["UserID"]=UserID;
    map["limit"]=limit;
    await HttpUtils.post("Account/GetUserInfoList", map).then((data){
      var infoResult = InfoResult.fromJson(data);
      switch(infoResult.statusCode){
        case 200:
          Store.value<UserModel>(context).setIfAuth(
              infoResult.data.data[0].ifAuth,
              infoResult.data.data[0].trueName,
              infoResult.data.data[0].iDCard,
              infoResult.data.data[0].address
          );
          break;
      }
    });
  }

/*
*  mPresenter.WorkerGetOrderList(userID, "0", Integer.toString(pageIndex), "10");
* */
/*获取可接工单*/
_getWorkInfo(String UserID,String State,String page,String limit) async{
  var data=Map();
  data["UserID"]=UserID;
  data["State"]=State;
  data["page"]=page;
  data["limit"]=limit;
  await HttpUtils.post("Order/WorkerGetOrderList", data).then((data){
    var getWorkResponse = GetWorkResponse.fromJson(data);
    switch(getWorkResponse.statusCode){
      case 200:
       if(getWorkResponse.data.count!="0"){//说明有单子
         setState(() {
           list_work.addAll(getWorkResponse.data.data);
         });
       }
       if(_refreshController.isRefresh){
         _refreshController.refreshCompleted();
       }if(_refreshController.isLoading){
         _refreshController.loadComplete();
       }
        break;
    }
  });
}

/*主账号接单操作*/
  /*{"StatusCode":200,"Info":"请求(或处理)成功","Data":{"Item1":true,"Item2":"操作成功"}}*/
_GrabSheet(String OrderID,int position,{String State="1"}) async{
  var data=Map();
  data["OrderID"]=OrderID;
  data["State"]=State;
  await HttpUtils.post("Order/UpdateSendOrderState", data).then((data){
    var baseResponse = BaseResponse.fromJson(data);
    switch(baseResponse.statusCode){
      case 200:
        Fluttertoast.showToast(msg: "接单成功");
        //接单成功后重新请求工单接口
        SpHelper.getUserName().then((UserName) {
          setState(() {
            list_work.removeAt(position);
          });

        });
        break;
    }

  });
  
}


}
