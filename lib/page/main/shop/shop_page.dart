


import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/provider/index.dart';
import 'package:flutter_app_zhkj_master/provider/model/ConfigModel.dart';
import 'package:flutter_app_zhkj_master/provider/model/UserModel.dart';


class MyShopItemPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyShopItemPage();
  }
}

class _MyShopItemPage extends State<MyShopItemPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:
      Center(
        child:
        Column(
          children: <Widget>[
            Store.connect<UserModel>(
                builder: (context, UserModel snapshot, child) {
                  return Text(
                      '${snapshot.username}'
                  );
                }
            ),
            Store.connect<ConfigModel>(
                builder: (context,ConfigModel snapshot,child){
                  return Text(
                      "${snapshot.theme}"
                  );
                }
            ),
            Text(Store.value<ConfigModel>(context).theme)
          ],
        ),
      )

    );
  }

}