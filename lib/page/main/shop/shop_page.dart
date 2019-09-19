


import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/provider/index.dart';
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
      body: Center(
        child: Store.connect<UserModel>(
            builder: (context, UserModel snapshot, child) {
              return Text(
                  '${snapshot.username}'
              );
            }
        ),
      ),
    );
  }

}