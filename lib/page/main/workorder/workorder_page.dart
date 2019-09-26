/*我的工单*/
import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/manager/resource_mananger.dart';
import 'package:flutter_app_zhkj_master/page/main/workorder/accessories_page.dart';
import 'package:flutter_app_zhkj_master/page/main/workorder/completed_page.dart';
import 'package:flutter_app_zhkj_master/page/main/workorder/failure_page.dart';
import 'package:flutter_app_zhkj_master/page/main/workorder/finish_wait_page.dart';
import 'package:flutter_app_zhkj_master/page/main/workorder/quality_page.dart';
import 'package:flutter_app_zhkj_master/page/main/workorder/received_page.dart';
import 'package:flutter_app_zhkj_master/page/main/workorder/service_page.dart';
import 'package:flutter_app_zhkj_master/page/main/workorder/stay_back_page.dart';
import 'package:flutter_app_zhkj_master/provider/index.dart';
import 'package:flutter_app_zhkj_master/provider/model/ConfigModel.dart';
import 'package:flutter_app_zhkj_master/provider/theme_util.dart';

class WorkorderPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _WorkorderPage();
  }
}
class _WorkorderPage extends State<WorkorderPage>{
  List<Widget> title;
  List<Widget> pages;
  @override
  void initState() {
    super.initState();
    title=List()..add(
        Text("已接待预约"),
    )..add(
        Text("服务中")
    )..add(
        Text("配件单")
    )..add(
        Text("待返件")
    )..add(
        Text("质保单")
    )..add(
        Text("完成待取机")
    )..add(
        Text("已完成")
    )..add(
        Text("预约不成功")
    );
    pages= List()..add(ReceivedPage())
                 ..add(ServicePage())
                 ..add(AccessoriesPage())
                 ..add(StayBackPage())
                 ..add(QualityPage())
                 ..add(FinishWaitPage())
                 ..add(CompletedPage())
                 ..add(FailurePage());
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 8,
        child:Scaffold(
            appBar: AppBar(
              title:
              Text("我的工单",
                style:TextStyle(
                    fontSize: 18,
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
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50),
                 child:  Material(
                   color: Colors.white,
                   child:Store.connect<ConfigModel>(
                       builder: (context, ConfigModel snapshot, child) {
                         return TabBar(
                           tabs: title,
                           labelColor: ThemeUtil.SetFontColor(snapshot.theme),
                           labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),
                           labelPadding: EdgeInsets.only(top:12,bottom: 12,left: 12,right: 12),
                           isScrollable: true,
                           unselectedLabelColor: Colors.black,
                           indicatorColor: ThemeUtil.SetFontColor(snapshot.theme),
                           indicatorWeight:1.6,
                           controller: DefaultTabController.of(context),
                         );
                       }
                   ),
                 ),
              )
            ),
            body: TabBarView(
              children: pages,
            )
        )
    );


  }

}