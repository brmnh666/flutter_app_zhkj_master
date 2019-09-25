import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/fluro/NavigatorUtil.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_app_zhkj_master/provider/index.dart';
import 'package:flutter_app_zhkj_master/provider/model/ConfigModel.dart';
import 'package:flutter_app_zhkj_master/provider/theme_util.dart';
import 'package:flutter_app_zhkj_master/util/fluro_convert_util.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPage extends StatefulWidget{
  final String url;
  final String title;
  WebPage({this.url,this.title});
  @override
  State<StatefulWidget> createState() {
    return _WebPage();
  }
}
class _WebPage extends State<WebPage>{
  String _url;
  String _title;
  @override
  void initState() {
    super.initState();

    _url=FluroConvertUtils.fluroCnParamsDecode(widget.url);
    _title=FluroConvertUtils.fluroCnParamsDecode(widget.title);
  }
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: _url,
      appBar:  AppBar(
        title: Text(_title,
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
       //Container(
       //  decoration: BoxDecoration(
       //      gradient: LinearGradient(
       //          colors: [Colors.cyan,Colors.blue,Colors.blueAccent,Colors.blue,Colors.cyan]
       //      )
       //  ),
       //) ,
      ),
    );
  }

}