/*已接待预约页面*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/bean/base_response.dart';
import 'package:flutter_app_zhkj_master/bean/get_work_response.dart' as work;
import 'package:flutter_app_zhkj_master/http/http_utils.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_app_zhkj_master/provider/index.dart';
import 'package:flutter_app_zhkj_master/provider/model/ConfigModel.dart';
import 'package:flutter_app_zhkj_master/provider/sp_helper.dart';
import 'package:flutter_app_zhkj_master/provider/theme_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReceivedPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ReceivedPage();
  }
}
class _ReceivedPage extends State<ReceivedPage> with AutomaticKeepAliveClientMixin{
  int _page=1;
  int _position_failure;//点击预约失败的位置
  int _position_failure_select;//点击预约失败时默认选择的位置
  List<work.Data2> _list_work=List();
  @override
  void initState() {
    SpHelper.getUserName().then((username)=>_GetWorkerGetOrderList(username,_page.toString()));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240,240,240),
      body: ListView.builder(
          itemCount: _list_work==0?0:_list_work.length,
          itemBuilder: (context,index){
           return index==_position_failure?
             //预约失败
            Store.connect<ConfigModel>(
               builder: (context, ConfigModel snapshot, child) {
                 return Container(
                     width: double.infinity,
                     height: 210,
                     margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                     decoration: BoxDecoration(
                         color: ThemeUtil.SetTransparencyColor(snapshot.theme),
                         borderRadius: BorderRadius.all(Radius.circular(8))
                     ),
                   child: Column(children: <Widget>[
                     Expanded(flex: 5,
                       child: Container(
                        child: Row(children: <Widget>[
                          Expanded(child: _item_select_failure(0,"ic_f_user.png","用户取消"),
                          ),
                          Expanded(child: _item_select_failure(1,"ic_f_phone.png","电话不通"),
                          ),
                          Expanded(child: _item_select_failure(2,"ic_f_qita.png","其他原因"),
                          )
                        ],
                       ),

                      ),
                     ),
                     Expanded(flex: 2,
                       child: Container(
                         decoration: BoxDecoration(
                           border: Border(top: BorderSide(width: 0.3,color: Colors.grey))
                         ),
                         child: Row(
                        children: <Widget>[
                          /*取消操作*/
                          Expanded(
                            child:GestureDetector(child:
                                 Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                    decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(width: 0.4,color: Colors.white)
                                ),
                                   child: Text("取消操作",style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.w500))
                            ),
                            onTap: (){
                              setState(() {
                                _position_failure=null;
                              });
                              }
                            ),

                          ),
                          /*确认*/
                          Expanded(
                            child: Store.connect<ConfigModel>(
                                builder: (context, ConfigModel snapshot, child) {
                                  return GestureDetector(
                                        child:Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                        decoration: BoxDecoration(
                                        color: ThemeUtil.SetFontColor(snapshot.theme),
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        border: Border.all(width: 0.4,color: Colors.white)
                                        ),
                                        child: Text("确认",style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.w500))
                                    ),
                                    onTap: (){
                                          switch(_position_failure_select){
                                            case 0:
                                              _AddOrderFailure(_list_work[index].orderID.toString(),"用户取消工单",index);
                                              break;
                                            case 1:
                                              _AddOrderFailure(_list_work[index].orderID.toString(),"电话打不通",index);
                                              break;
                                            case 2:
                                              _AddOrderFailure(_list_work[index].orderID.toString(),"其他原因",index);
                                              break;
                                          }

                                    });


                                }
                            ),
                                
                            
                          )

                        ],

                      ),

                      ),
                     ),
                   ],),
                   );
                }
              ):
             Container(
             width: double.infinity,
             height: 210,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.all(Radius.circular(8))
             ),
             margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
             child: Column(
               children: <Widget>[
                 /*第一行*/
                 Container(
                   padding: EdgeInsets.only(left: 12,top: 12,right: 12),
                   child: Row(
                     children: <Widget>[
                       Text("已接单待联系客户",style: TextStyle(fontSize: 12,color: Color.fromARGB(205, 115,115,115))),
                       Container(
                         margin: EdgeInsets.only(left: 5),
                         decoration: BoxDecoration(
                           color: Colors.red,
                           borderRadius: BorderRadius.all(Radius.circular(3))
                         ),
                         padding: EdgeInsets.only(left: 3,right: 3,top: 1,bottom: 1),
                         child: Text("${_list_work[index].typeName}/${_list_work[index].guarantee=='Y'?'保内':'保外'}",style: TextStyle(color: Colors.white,fontSize: 8)),
                       ),
                       Expanded(child: Container(
                         alignment: Alignment.centerRight,
                         child: Text("工单号:${_list_work[index].orderID}",style: TextStyle(fontSize: 12,color: Color.fromARGB(205, 115,115,115))),
                        )
                       )
                     ],
                   ),
                 ),
                 /*第二行*/
                 Container(
                   height: 110,
                   width: double.infinity,
                   padding: EdgeInsets.only(left: 12,right: 12,top: 5),
                   child: Row(
                     children: <Widget>[
                       Expanded(flex: 3,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           Expanded(flex: 2,child:
                           Container(
                             alignment: Alignment.centerLeft,
                             child:Text("${_list_work[index].memo}",
                             style: TextStyle(fontSize: 19)),
                           )
                       ),
                           Expanded(flex:1,
                               child: Row(
                               children: <Widget>[
                                /*距离*/
                                 Image.asset(ImageHelper.wrapAssets("icon_loaction.png")
                                 ,width: 14,height: 14),
                                   Padding(padding: EdgeInsets.only(left: 5),
                                      child: Text("距离 ${_list_work[index].distance}Km",style: TextStyle(fontSize:14,color: Color.fromARGB(205, 115,115,115))
                                  )
                               ),

                               Padding(padding: EdgeInsets.only(left: 40),
                                   child: Text("数量:${_list_work[index].num}台",style: TextStyle(fontSize:13,color: Color.fromARGB(205, 115,115,115))))

                             ],
                           )),
                           Expanded(flex: 2,child:
                           Container(
                             margin: EdgeInsets.only(top: 2),
                             alignment: Alignment.centerLeft,
                             child: Text("${_list_work[index].address}",
                               style: TextStyle(fontSize:14,color: Color.fromARGB(205, 115,115,115))),
                           )


                       ),
                         ],
                       ),
                       ),
                       Expanded(
                         flex: 1,
                         child: Center(child:
                         Store.connect<ConfigModel>(
                             builder: (context, ConfigModel snapshot, child) {
                               return Image.asset(ImageHelper.wrapAssets("icon_telphone${ThemeUtil.SetPhotoColor(snapshot.theme)}.png")
                                   ,width: 51,height: 51);
                             }
                          ),
                         ),
                       )
                     ],
                   ),
                 ),
                 /*第三行*/
                 Container(
                   alignment: Alignment.centerLeft,
                   padding: EdgeInsets.only(left: 12,right: 12),
                   child: Text("工单将在...之后取消，请及时联系客户",style: TextStyle(color: Colors.red),),
                 ),

                 /*横线*/
                 Container(
                   margin: EdgeInsets.only(top: 5),
                   width: double.infinity,
                   height: 0.3,
                   color: Colors.grey,
                 ),

                 /*第四行*/
                 Container(
                   width: double.infinity,
                   child: Row(
                     children: <Widget>[
                       /*预约失败*/
                       Expanded(child:
                       GestureDetector(
                         child:Container(
                           alignment: Alignment.center,
                           height: 35,
                           decoration: BoxDecoration(
                               color: Colors.red,
                               borderRadius: BorderRadius.all(Radius.circular(5)),
                               border: Border.all(width: 0.4,color: Colors.grey)
                           ),
                           margin: EdgeInsets.only(left: 10,right: 6,top: 4),
                           child: Text("预约失败",style: TextStyle(
                               color: Colors.white,
                               fontSize: 15,fontWeight: FontWeight.w500)
                           ),
                         ),
                         onTap: (){
                           setState(() {
                             _position_failure=index;
                             _position_failure_select=0;
                           });
                         },
                       ),



                       ),
                       /*预约成功*/
                       Expanded(child: Container(
                         height: 35,
                         alignment: Alignment.center,
                         margin: EdgeInsets.only(left: 6,right: 6,top: 4),
                         decoration: BoxDecoration(
                             color: Colors.green,
                             borderRadius: BorderRadius.all(Radius.circular(5)),
                             border: Border.all(width: 0.4,color: Colors.grey)
                         ),
                         child: Text("预约成功",style: TextStyle(
                             color: Colors.white,
                             fontSize: 15,fontWeight: FontWeight.w500)
                         ),
                        )
                       ),

                       /*转派工单*/
                       Expanded(child: Container(
                         height: 35,
                         alignment: Alignment.center,
                         margin: EdgeInsets.only(left: 6,right: 6,top: 4),
                         decoration: BoxDecoration(
                             color: Colors.blue,
                             borderRadius: BorderRadius.all(Radius.circular(5)),
                             border: Border.all(width: 0.4,color: Colors.grey)
                         ),
                         child: Text("转派工单",style: TextStyle(
                             color: Colors.white,
                             fontSize: 15,fontWeight: FontWeight.w500))
                       ),
                       ),
                       /*取消工单*/
                       Expanded(child: Container(
                         height: 35,
                         alignment: Alignment.center,
                         margin: EdgeInsets.only(left: 6,right: 10,top: 4),
                         decoration: BoxDecoration(
                             color: Colors.black,
                             borderRadius: BorderRadius.all(Radius.circular(5)),
                              border: Border.all(width: 0.4,color: Colors.grey)
                         ),
                         child:Text("取消工单",style: TextStyle(
                             color: Colors.white,
                             fontSize: 15,fontWeight: FontWeight.w500))
                       )
                       ),
                     ],
                   ),
                 )
               ],
             )
            );

      })
    );
  }

 /* UserID=18892621501&State=1&page=1&limit=5
 *Order/WorkerGetOrderList
 * 获取已接待预约工单列表
 * */

 _GetWorkerGetOrderList(String UserID,String page,{String State="1",String limit="5"})async{
   var data =Map();
   data["UserID"]=UserID;
   data["page"]=page;
   data["State"]=State;
   data["limit"]=limit;

   await HttpUtils.post("Order/WorkerGetOrderList", data).then((result){
     var getWorkResponse = work.GetWorkResponse.fromJson(result);
     switch(getWorkResponse.statusCode){
       case 200:
         if(getWorkResponse.data.data.length!=0){
           setState(() {
             _list_work=getWorkResponse.data.data;
           });
         }
         break;
     }
   });
 }

 /*http://47.96.126.145:8001/api/Order/UpdateSendOrderAppointmentState
 OrderID=2000002031&AppointmentState=-1&AppointmentMessage=xxxxx
 {"StatusCode":200,"Info":"请求(或处理)成功","Data":{"Item1":true,"Item2":""}}
 * 提交预约失败原因
 * */
 _AddOrderFailure(String OrderID,String AppointmentMessage,int index,{String AppointmentState}) async{
   var data =Map();
   data["OrderID"]=OrderID;
   data["AppointmentState"]=AppointmentState;
   data["AppointmentMessage"]=AppointmentMessage;
   await HttpUtils.post("Order/UpdateSendOrderAppointmentState", data).then((result){
      var baseResponse = BaseResponse.fromJson(result);
      switch(baseResponse.statusCode){
        case 200:
          if(baseResponse.data.item1){
            Fluttertoast.showToast(msg: "处理成功");
            setState(() {
              _list_work.removeAt(index);
              _position_failure=null;
            });
          }
          break;
      }
    }
   );

 }




 Widget _item_select_failure(int index,String photo,String content){
   return _position_failure_select==index?
   Store.connect<ConfigModel>(
       builder: (context, ConfigModel snapshot, child) {
         return Container(
             height: 90,
             margin: EdgeInsets.only(left: 10,right: 10,top: 28,bottom: 30),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.all(Radius.circular(10)),
               color: ThemeUtil.SetFontColor(snapshot.theme),
               border: Border.all(width: 2.0,color: Colors.white)
             ),
             child: Container(
                 margin: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 15),
                 child:Column(children: <Widget>[
                   Image.asset(ImageHelper.wrapAssets(photo),width: 30,height: 30),
                   Padding(padding: EdgeInsets.only(top: 5),
                     child:Text(content,style: TextStyle(color: Colors.white,fontSize: 10)
                     )
                     ,)
                 ],
                 )
             )
         );
       }
     ):
     Store.connect<ConfigModel>(
       builder: (context, ConfigModel snapshot, child) {
         return GestureDetector(
             child:   Container(
               height: 90,
               margin: EdgeInsets.only(left: 10,right: 10,top: 28,bottom: 30),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(10)),
                 color: ThemeUtil.SetFontColor(snapshot.theme),
               ),
               child: Container(
                   margin: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 15),
                   child:Column(children: <Widget>[
                     Image.asset(ImageHelper.wrapAssets(photo),width: 30,height: 30),
                     Padding(
                       padding: EdgeInsets.only(top: 5),
                       child:Text(content,style: TextStyle(color: Colors.white,fontSize: 10)),
                     )
                   ],
                   )
               ) ,
             ),
             onTap: (){
               setState(() {
                 _position_failure_select=index;
               });
             },
           );

       }
   );
 }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}