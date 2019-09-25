import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/http/http_utils.dart';
import 'package:flutter_app_zhkj_master/bean/updataname.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_app_zhkj_master/provider/index.dart';
import 'package:flutter_app_zhkj_master/provider/model/ConfigModel.dart';
import 'package:flutter_app_zhkj_master/provider/model/UserModel.dart';
import 'package:flutter_app_zhkj_master/provider/sp_helper.dart';
import 'package:flutter_app_zhkj_master/provider/theme_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

/*修改名称*/
class MyupdateShopname extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyupdateShopname();
  }
}
class _MyupdateShopname extends State<MyupdateShopname>{
  TextEditingController controller=TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("修改店铺名",
          style:TextStyle(
              fontSize: 15,
              color: Colors.white
          ),
        ),
        centerTitle: true,
        leading: IconButton(icon: Image.asset(ImageHelper.wrapAssets("icon_actionbar_return.png"),
          width: 20,
          height: 20,
        ), onPressed: (){Navigator.pop(context);}
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

       // Container(
       //   decoration: BoxDecoration(
       //       gradient: LinearGradient(
       //           colors: [Colors.cyan,Colors.blue,Colors.blueAccent,Colors.blue,Colors.cyan]
       //       )
       //   ),
       // ) ,
      ),

      body:Column(children: <Widget>[
        Container(
            margin: EdgeInsets.only(left: 10,right: 10,top: 10),
            child: TextField(
          //控制器 可以获取内容
          controller: controller, //给TextField设置装饰（形状等）
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  color: Colors.black12),
            ),
            //输入内容距离上下左右的距离 ，可通过这个属性来控制 TextField的高度
            contentPadding: EdgeInsets.only(top: 10,bottom: 10,left: 10),
            hintText: "请输入店铺名",
          ),
          ///光标设置
          cursorColor: Colors.black,
          cursorWidth: 2,
          cursorRadius: Radius.circular(1),
          //键盘类型设置
          keyboardType: TextInputType.text,
          //是否是密码
          obscureText: false,


        )
        ),


       GestureDetector(
         child:
         Store.connect<ConfigModel>(
             builder: (context, ConfigModel snapshot, child) {
               return Container(
                 child:Center(child:
                 Text("修改",style: TextStyle(fontSize: 15,color: Colors.white))),
                 padding: EdgeInsets.only(top: 12,bottom: 12),
                 width: double.infinity,
                 margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                 decoration: BoxDecoration(
                     color: ThemeUtil.SetFontColor(snapshot.theme),
                     borderRadius: BorderRadius.all(Radius.circular(5))
                 ),
               );
             }
         ),

       onTap: ()
       {
         if(controller.text==null||controller.text==""){
           Fluttertoast.showToast(msg: "请输入正确的店铺名");
         }else{
           SpHelper.getUserName().then((UserName)=> _updateshopname(controller.text,UserName));
         }

       },
       )

    ]
    )
    );
  }

    _updateshopname(String NickName,String UserID)async{
    var map=Map();
    map["UserID"]=UserID;
    map["NickName"]=NickName;
    await HttpUtils.post("Account/UpdateAccountNickName", map).then((data){
     var updataname = Updataname.fromJson(data);
     switch(updataname.statusCode){
        case 200:
         if(updataname.data.item1){
           Fluttertoast.showToast(msg: "修改成功");
           Store.value<UserModel>(context).setShopName(NickName);
           NavigatorUtil.goBack(context);
         }
         break;
      }

    });
  }


}


