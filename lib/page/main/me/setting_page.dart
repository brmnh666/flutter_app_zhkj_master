import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SettingPage();
  }

}
class _SettingPage extends State<SettingPage>{

  int _position=0;
  String _hint="当前选中了默认蓝";
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,245,242,245),
      appBar: AppBar(
        title: Text("设置",
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
        ), onPressed: (){ Navigator.pop(context);}
        ),
        flexibleSpace:Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.cyan,Colors.blue,Colors.blueAccent,Colors.blue,Colors.cyan]
              )
          ),
        ) ,
      ),
     body: Column(
       children: <Widget>[
         /*设置主题颜色*/
         Container(
           width: double.infinity,
           height: 120,
           color: Colors.white,
           child: Column(
             children: <Widget>[
               /**/
               Container(
                 alignment: Alignment.centerLeft,
                 width: double.infinity,
                 padding: EdgeInsets.only(left: 10),
                 height: 40,
                 decoration: BoxDecoration(
                     border: Border(top: BorderSide(color: Colors.grey,width: 0.3),bottom:BorderSide(color: Colors.grey,width: 0.3))
                  ),
                  child:
                  Row(children: <Widget>[
                   Text("设置主题色",style: TextStyle(fontSize: 14)),
                    Expanded(child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 4,right: 4,top: 2,bottom: 2),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(200, 255,152,0),
                          borderRadius: BorderRadius.all(Radius.circular(4))
                        ),
                        
                        child: Text(_hint,style: TextStyle(fontSize: 12,color: Colors.white)),
                      )

                    ))
                    
                 ],)




               ),

               Container(
                 width: double.infinity,
                 height: 80,
                 padding: EdgeInsets.only(left: 10,right: 10),
                 decoration: BoxDecoration(
                   border: Border(bottom: BorderSide(color: Colors.grey,width: 0.2))
                 ),
                 child:Row(
                   children: <Widget>[
                     Expanded(flex:1,child:
                     selecttheme_item(0, "blue","默认蓝")
                     ),
                     Expanded(flex:1,child:
                     selecttheme_item(1, "yellow","柠檬黄")),
                     Expanded(flex:1,child:
                     selecttheme_item(2, "green","薄荷绿")
                     ),
                     Expanded(flex:1,child:
                     Container(
                       width: 56,
                       height: 56,
                       alignment: Alignment.center,
                       padding: EdgeInsets.all(8),
                       margin: EdgeInsets.only(left: 14,right: 14),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.all(Radius.circular(28)),
                         border: Border.all(color: Colors.black,width: 0.2)

                       ),
                       child: Text("更多主题敬请期待",style: TextStyle(fontSize: 10)),
                     )

                     ),
                   ],
                 )
               ),
             ],
           ),
         )
       ],
     )

    );
  }

  Color _getcolor(String color){
    switch(color){
      case "blue":
        return Colors.blue;
      case "yellow":
        return Colors.yellow;
      case "green":
        return Colors.green;
    }
  }

  Widget selecttheme_item(int index,String color,String strColor){
    return index==_position?
        //选中情况
      Container(
        width: 56,
        height: 56,
          alignment: Alignment.center,
        margin: EdgeInsets.only(left: 14,right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(28)),
          color:_getcolor(color),
            // 生成俩层阴影，一层绿，一层黄， 阴影位置由offset决定,阴影模糊层度由blurRadius大小决定（大就更透明更扩散），阴影模糊大小由spreadRadius决定
            boxShadow: [BoxShadow(color: Colors.grey,
                       offset: Offset(0.0, 0.0),
                       blurRadius: 2.0,
                       spreadRadius: 1.0
                       ),
                       ],

        ),
        child:Text(strColor,style: TextStyle(fontSize: 13,color: Colors.white,fontWeight: FontWeight.w600))
    ):
    //未选中情况
    GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: 56,
        height: 56,
        margin: EdgeInsets.only(left: 14,right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(28)),
          color:_getcolor(color),
        ),
       child:Text(strColor,style: TextStyle(fontSize: 12,color: Colors.white))
      ),
      onTap: () {
          setState(() {
            _position=index;
            _hint="当前选中了${strColor}";
            /*将所选的颜色存入sp中*/
           //SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
           //sharedPreferences.setString("Theme", color);
          });


      },
    );


  }

}