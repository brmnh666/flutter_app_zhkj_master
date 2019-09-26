
import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/bean/base_response.dart' as base_response;
import 'package:flutter_app_zhkj_master/bean/get_area_response.dart' as area;
import 'package:flutter_app_zhkj_master/bean/get_province_response.dart' as province;
import 'package:flutter_app_zhkj_master/bean/service_response.dart';
import 'package:flutter_app_zhkj_master/http/http_utils.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_app_zhkj_master/provider/index.dart';
import 'package:flutter_app_zhkj_master/provider/model/ConfigModel.dart';
import 'package:flutter_app_zhkj_master/provider/sp_helper.dart';
import 'package:flutter_app_zhkj_master/provider/theme_util.dart';
import 'package:flutter_app_zhkj_master/widgets/popup_window.dart';
import 'package:fluttertoast/fluttertoast.dart';

/*修改服务区域*/
class MyUpdateServicePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyUpdateServicePage();
  }
}
class _MyUpdateServicePage extends State<MyUpdateServicePage>{
  List<Data> list =List();//用于存放返回的地址
  List<province.Data> list_province=List(); //用于存放省份
  List<area.Item2> list_city=List();//用于存放城市
  List<area.Item2> list_area=List();//用于存放区域
  List<area.Item2> list_district=List();//用于存放街道

  String _province="省";//存放所选的省
  String _city="市";//存放所选的市
  String _area="区";//存放所选的区
  String _district="街道"; //存放所选的街道

  String _province_code; //存放所选省的code
  String _city_code; //存放所选省的code
  String _area_code; //存放所选省的code
  String _district_code; //存放所选省的code


  GlobalKey popBottomKey;
  @override
  void initState() {
    super.initState();
    SpHelper.getUserName().then((UserName)=> _getServiceByUserId(UserName));
    _GetProvince();
    popBottomKey=GlobalKey();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:
      AppBar(
        title: Text("服务区域选择",
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
          Navigator.pop(context);
        }
        ),
        flexibleSpace:

        Store.connect<ConfigModel>(
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
       //Container(
       //  decoration: BoxDecoration(
       //      gradient: LinearGradient(
       //          colors: [Colors.cyan,Colors.blue,Colors.blueAccent,Colors.blue,Colors.cyan]
       //      )
       //  ),
       //) ,
        elevation: 0.0,
      ),
      body:


          Column(
            children: <Widget>[

              /*实现蓝色渐变背景*/
              Stack(
                children: <Widget>[
                  Store.connect<ConfigModel>(
                      builder: (context, ConfigModel snapshot, child) {
                        return  Container(
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: ThemeUtil.setActionBar(snapshot.theme)
                              )
                          ),
                        );
                      }
                  ),
                /// Container(
                ///     width: double.infinity,
                ///     height: 120,
                ///     decoration: BoxDecoration(
                ///     gradient: LinearGradient(
                ///     colors: [Colors.cyan,Colors.blue,Colors.blueAccent,Colors.blue,Colors.cyan]
                /// )
                ///  ),
                /// ),

                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                           ),

                    ),
                    child: Column(children: <Widget>[
                      /*选择服务区域*/

                      Container(
                        alignment: Alignment.topLeft,
                        child:  Text("选择服务区域",style: TextStyle(color: Color.fromARGB(255,90,90,91),fontSize:16)),
                        margin: EdgeInsets.only(top: 15,left: 15,bottom: 15),
                      ),

                      /*省，市，区街道*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          /*省*/
                          GestureDetector(
                            child: Container(
                            key: popBottomKey,
                            margin: EdgeInsets.only(left: 5,right: 5),
                            width: 72,
                            height: 33,
                            padding: EdgeInsets.only(left: 13,right: 5),
                            decoration: BoxDecoration(
                                border:Border.all(color: Color.fromARGB(255,199,199,199)),
                                borderRadius: BorderRadius.all(Radius.circular(9))
                            ),
                            //显示水平文字和下箭头

                              child: Row(
                                children: <Widget>[
                                Expanded(child:Text(/*超出部分显示...*/
                                _province,
                                softWrap: true,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                                ),
                                ),
                                Image.asset(ImageHelper.wrapAssets("sanjiaoxia.png"),width: 10,height: 10)
                              ],
                            ),
                          ),
                          onTap: (){
                              PopupWindow.showPopWindow(context,"bottom", popBottomKey,PopDirection.bottom,build_province_Widget(),2);

                          },
                          ),

                          /*市*/
                          GestureDetector(
                            child:Container(
                              margin: EdgeInsets.only(left: 5,right: 5),
                              width: 72,
                              height: 33,
                              padding: EdgeInsets.only(left: 13,right: 5),
                              decoration: BoxDecoration(
                                  border:Border.all(color: Color.fromARGB(255,199,199,199)),
                                  borderRadius: BorderRadius.all(Radius.circular(9))
                              ),
                              //显示水平文字和下箭头
                              child: Row(
                                children: <Widget>[
                                  Expanded(child:Text(/*超出部分显示...*/
                                    _city,
                                    softWrap: true,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),),
                                  Image.asset(ImageHelper.wrapAssets("sanjiaoxia.png"),width: 10,height: 10)
                                ],
                              ),
                            ),
                            onTap: (){
                              if(_province=="省"){ //省为选不能选市
                               Fluttertoast.showToast(msg: "请先选择省");
                              }else{
                                PopupWindow.showPopWindow(context,"bottom", popBottomKey,PopDirection.bottom,build_cad_Widget("市"),2);

                              }

                            },
                          ),






                          /*区*/
                          GestureDetector(
                            child:Container(
                              margin: EdgeInsets.only(left: 5,right: 5),
                              width: 72,
                              height: 33,
                              padding: EdgeInsets.only(left: 13,right: 5),
                              decoration: BoxDecoration(
                                  border:Border.all(color: Color.fromARGB(255,199,199,199)),
                                  borderRadius: BorderRadius.all(Radius.circular(9))
                              ),
                              //显示水平文字和下箭头
                              child: Row(
                                children: <Widget>[
                                  Expanded(child:Text(/*超出部分显示...*/
                                    _area,
                                    softWrap: true,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),),
                                  Image.asset(ImageHelper.wrapAssets("sanjiaoxia.png"),width: 10,height: 10)
                                ],
                              ),
                            ),
                            onTap: (){
                              if(_province=="省"){
                                Fluttertoast.showToast(msg: "请先选择省");
                                return;
                              }
                              if(_city=="市"){
                                Fluttertoast.showToast(msg: "请先选择市");
                                return;
                              }
                              PopupWindow.showPopWindow(context,"bottom", popBottomKey,PopDirection.bottom,build_cad_Widget("区"),2);

                            },
                          ),


                          /*街道*/
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(left: 5,right: 5),
                              width: 72,
                              height: 33,
                              padding: EdgeInsets.only(left: 13,right: 5),
                              decoration: BoxDecoration(
                                  border:Border.all(color: Color.fromARGB(255,199,199,199)),
                                  borderRadius: BorderRadius.all(Radius.circular(9))
                              ),
                              //显示水平文字和下箭头
                              child: Row(
                                children: <Widget>[
                                  Expanded(child:Text(/*超出部分显示...*/
                                    _district,
                                    softWrap: true,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),),
                                  Image.asset(ImageHelper.wrapAssets("sanjiaoxia.png"),width: 10,height: 10)
                                ],
                              ),
                            ),
                            onTap: (){
                              if(_province=="省"){
                                Fluttertoast.showToast(msg: "请先选择省");
                                return;
                              }
                              if(_city=="市"){
                                Fluttertoast.showToast(msg: "请先选择市");
                                return;
                              }
                              if(_area=="区"){
                                Fluttertoast.showToast(msg: "请先选择区");
                                return;
                              }

                              PopupWindow.showPopWindow(context,"bottom", popBottomKey,PopDirection.bottom,build_cad_Widget("街道"),2);
                            },
                          )

                        ],
                      ),


                      /*添加按钮*/
                      GestureDetector(
                        child:Container(
                        margin: EdgeInsets.only(top: 18,bottom: 20),
                        child: Image.asset(ImageHelper.wrapAssets("tianjia.png"),width: 35,height: 35),
                        ) ,
                        onTap: (){
                        /*添加分两种情况一种选择到区(把所有街道都添加)  一种选择到街道（只添加当前街道）*/
                          /*先判断是否选择省市区*/
                          if(_province=="省"){
                            Fluttertoast.showToast(msg: "请先选择省份");
                             return;
                          }
                          if(_city=="市"){
                            Fluttertoast.showToast(msg: "请选择城市");
                            return ;
                          }
                          if(_area=="区"){
                            Fluttertoast.showToast(msg: "请选择区");
                            return ;
                          }
                          if(_district=="街道"){//第一种情况添加所有街道
                            /*找到相同先删除*/
                            if(list.length!=0){
                              for(int i=0;i<list.length;i++){
                                for(int j=0;j<list_district.length;j++){
                                  if(list[i].districtCode==list_district[j].code){
                                    list.removeAt(i);
                                  }
                                }
                              }
                              setState(() {
                                /*添加*/
                                for(int i=0;i<list_district.length;i++){
                                  list.add(Data(0,0,"userid",_province_code,_province,_city_code,_city,_area_code,_area,list_district[i].code,list_district[i].name,"Y",0));
                                }
                                _province="省";
                                _city="市";
                                _area="区";
                                _district="街道";
                                _province_code=null;
                                _city_code=null;
                                _area_code=null;
                                _district_code=null;

                              });

                            }
                            else{//没数据将所有街道添加进去
                              setState(() {
                                for(int i=0;i<list_district.length;i++){
                                  list.add(Data(0,0,"userid",_province_code,_province,_city_code,_city,_area_code,_area,list_district[i].code,list_district[i].name,"Y",0));
                                }
                                 _province="省";
                                 _city="市";
                                 _area="区";
                                 _district="街道";
                                 _province_code=null;
                                 _city_code=null;
                                 _area_code=null;
                                 _district_code=null;
                              });

                            }

                          }else{

                            //第二种情况添加这条所选街道
                            //判断所选街道是否已经添加
                            if(list.length!=0){
                              /*遍历返回的list查看是否有该街道有就删除*/
                              for(int i=0;i<list.length;i++){
                                if(_district_code==list[i].districtCode){//存在该街道不添加
                                  Fluttertoast.showToast(msg: _district_code);
                                  list.removeAt(i);
                                }
                              }
                              /*再添加该街道*/
                              setState(() {
                                list.add(Data(0,0,"userid",_province_code,_province,_city_code,_city,_area_code,_area,_district_code,_district,"Y",0));
                                _province="省";
                                _city="市";
                                _area="区";
                                _district="街道";
                                _province_code=null;
                                _city_code=null;
                                _area_code=null;
                                _district_code=null;
                              });

                            }else{//没有数据直接添加
                              setState(() {
                                list.add(Data(0,0,"userid",_province_code,_province,_city_code,_city,_area_code,_area,_district_code,_district,"Y",0));
                                _province="省";
                                _city="市";
                                _area="区";
                                _district="街道";
                                _province_code=null;
                                _city_code=null;
                                _area_code=null;
                                _district_code=null;
                              });
                            }

                          }


                      },)

                    ],
                    ),
                  ),
                ],
              ),

              /*列表显示地区*/
              Expanded(
                  child: ListView.builder(
                      itemCount:  (list== null) ? 0 : list.length,
                      itemBuilder:(BuildContext context,int index){
                        //条目构造器
                        return Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 10,right: 10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(bottom: BorderSide(color: Color.fromARGB(255,228,228,228)))
                          ),
                          child: Row(
                            children: <Widget>[
                            /*区域图标*/
                             Padding(padding: EdgeInsets.only(left:10,right: 10,top: 5,bottom: 5),
                             child:Image.asset(ImageHelper.wrapAssets("quyu.png"),width: 15,height: 15,)
                             ),
                            /*地址内容*/
                              Expanded(child:
                              Text("${list[index].provinceName+"-"+list[index].cityName+"-"+list[index].areaName+"-"+list[index].districtName}",style: TextStyle(fontSize: 16)),
                              ),

                            /*垃圾箱删除*/
                              GestureDetector(
                                  child:
                                   Padding(padding: EdgeInsets.only(right: 10),
                                  child:  Image.asset(ImageHelper.wrapAssets("shanchu.png"),width: 15,height: 15,)
                                   ),onTap:(){
                                    setState(() {
                                      list.removeAt(index);
                                    });
                                    },)

                          ],)

                        );
                      }
                  )
              ),

              /*申请审核*/

              GestureDetector(
                child:

                Store.connect<ConfigModel>(
                    builder: (context, ConfigModel snapshot, child) {
                      return Container(
                        width:double.infinity,
                        height: 48,
                        margin: EdgeInsets.only(left: 15,right: 15),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors:ThemeUtil.setActionBar(snapshot.theme)
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8))

                        ),
                        alignment: Alignment.center,
                        child: Text("提交申请",style: TextStyle(fontSize: 18,color: Colors.white)),
                      );
                    }
                ),
                onTap: (){
                  //获取list中的省份市区街道 111-222-333-444用逗号隔开
                  if(list.length==0){
                    Fluttertoast.showToast(msg: "请先添加地址");
                    return;
                  }
                  //开始拼接省市区街道
                  String mServiceAreaJsonStr="";//拼接的结果
                  for(int i=0;i<list.length;i++){
                    mServiceAreaJsonStr=mServiceAreaJsonStr+list[i].provinceCode+"-"+list[i].cityCode+"-"+list[i].areaCode+"-"+list[i].districtCode+",";
                  }
                  //去掉最后一个逗号
                  SpHelper.getUserName().then((UserName)=> _SubmitAudit(UserName,mServiceAreaJsonStr.substring(0,mServiceAreaJsonStr.length-1)));

                },

              )


            ],

          )



    );
  }


  /*获取我已经选择的服务地址*/
  _getServiceByUserId(String UserID)async{
    var map=Map();
    map["UserID"]=UserID;
    await HttpUtils.post("Account/GetServiceRangeByUserID", map).then((data){
      var serviceResponse = ServiceResponse.fromJson(data);
      switch(serviceResponse.statusCode){
        case 200:
          setState(() {
            list.addAll(serviceResponse.data);
          });
          break;
      }

    });
  }


  /*获取省份*/
    _GetProvince() async{
    await HttpUtils.post("Config/GetProvince", null).then((data){
       var getProvinceResponse = province.GetProvinceResponse.fromJson(data);
       switch(getProvinceResponse.statusCode){
         case 200:
           if(getProvinceResponse.data.length!=0){
             setState(() {
               list_province.addAll(getProvinceResponse.data);
             });

           }
           break;
       }

    });
  }

  /*获取市*/
  _GetCity(String parentcode)async{
    var map=Map();
    map["parentcode"]=parentcode;
    await HttpUtils.post("Config/GetCity", map).then((data){
      var getAreaResponse = area.GetAreaResponse.fromJson(data);
      switch(getAreaResponse.statusCode){
        case 200:
          if(getAreaResponse.data.item1){
            setState(() {
              list_city=getAreaResponse.data.item2;
            });
          }
          break;

      }


    });

  }

    /*获取区*/
   _GetArea(String parentcode)async{
     var map=Map();
     map["parentcode"]=parentcode;
     await HttpUtils.post("Config/GetArea", map).then((data){
       var getAreaResponse = area.GetAreaResponse.fromJson(data);
       switch(getAreaResponse.statusCode){
         case 200:
           if(getAreaResponse.data.item1){
             setState(() {
               list_area=getAreaResponse.data.item2;
             });
           }

           break;
       }

     });

   }

  /*获取街道*/

  _GetDistrict(String parentcode)async{
    var map=Map();
    map["parentcode"]=parentcode;
    await HttpUtils.post("Config/GetDistrict", map).then((data){
      var getAreaResponse = area.GetAreaResponse.fromJson(data);
      switch(getAreaResponse.statusCode){
        case 200:
          if(getAreaResponse.data.item1){
            list_district=getAreaResponse.data.item2;
          }
          break;
      }
    });
  }

  /*提交审核*/
  _SubmitAudit(String UserID,String ServiceAreaJsonStr)async{
    var map=Map();
    map["UserID"]=UserID;
    map["ServiceAreaJsonStr"]=ServiceAreaJsonStr;

    await HttpUtils.post("Account/AddorUpdateServiceArea", map).then((data){
      var baseResponse = base_response.BaseResponse.fromJson(data);
      switch(baseResponse.statusCode){
        case 200:
          if(baseResponse.data.item1){
            Fluttertoast.showToast(msg: "提交成功");
            Navigator.pop(context);
          }
          break;

      }


    });



  }



  /*弹出的省的Widget*/
  Widget build_province_Widget() {
    return Store.connect<ConfigModel>(
          builder: (context, ConfigModel snapshot, child) {
            return  Container(
                width: 150,
                height: 200,
                margin: EdgeInsets.only(left: 20),
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    gradient: LinearGradient(
                        colors: ThemeUtil.setActionBar(snapshot.theme)
                    )
                ),
                child:ListView.builder(
                    itemCount:(list_province== null) ? 0 : list_province.length,
                    itemBuilder:(BuildContext context,int index){
                      return GestureDetector(
                        child: Container(
                          height: 30,
                          child: Text(list_province[index].name,style: TextStyle(fontSize: 15,color: Colors.white),),
                        ),
                        onTap: (){
                          setState(() {
                            _province=list_province[index].name;
                            _province_code=list_province[index].code;
                            //选择省份市其他重置

                            _city_code=null;
                            _area_code=null;
                            _district_code=null;

                            _city="市";
                            _area="区";
                            _district="街道";
                          });

                          /*选择了省 确定市*/
                          _GetCity(list_province[index].code);
                          Navigator.pop(context);
                        },
                      );

                    }
                )
            );
          }
      );
     }

  /*弹出的市区街道的Widget*/
  Widget build_cad_Widget(String type) {
    var list=List<area.Item2>();
    double maginleft;
    switch(type){
      case "市":
        list=list_city;
        maginleft=100;
        break;
      case "区":
        list=list_area;
        maginleft=180;
        break;
      case "街道":
        list=list_district;
        maginleft=180;
        break;
    }
    return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 200,minHeight: 50),
        child:Store.connect<ConfigModel>(
            builder: (context, ConfigModel snapshot, child) {
              return  Container(
                width: 150,
                margin: EdgeInsets.only(left: maginleft,right: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    gradient: LinearGradient(
                        colors: ThemeUtil.setActionBar(snapshot.theme)
                    )
                ),
                child:
                ListView.builder(
                    itemCount:  (list== null) ? 0 : list.length,
                    itemBuilder:(BuildContext context,int index){
                      return
                        GestureDetector(
                          child: Container(
                            height: 38,
                            child: Text(list[index].name,style: TextStyle(fontSize: 15,color: Colors.white),),
                          ),
                          onTap: (){
                            setState(() {
                              /*判断是哪个弹框*/
                              switch(type){
                                case "市":
                                  _city=list[index].name;
                                  _city_code=list[index].code;

                                  _GetArea(list[index].code);
                                  //选择市区和街道重置
                                  _area_code=null;
                                  _district_code=null;

                                  _area="区";
                                  _district="街道";
                                  break;
                                case "区":
                                  _area=list[index].name;
                                  _area_code=list[index].code;

                                  _GetDistrict(list[index].code);
                                  //选择区 街道重置
                                  _district_code=null;
                                  _district="街道";
                                  break;
                                case "街道":
                                  _district=list[index].name;
                                  _district_code=list[index].code;
                                  break;
                              }
                            });
                            Navigator.pop(context);
                          },
                        );
                    }
                ) ,
              );
            }
        ),


      );



  }






}



