import 'package:flutter/material.dart';
import 'package:flutter_app_zhkj_master/provider/index.dart';
import 'package:flutter_app_zhkj_master/provider/model/UserModel.dart';


class MyMessageItemPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomeItemPage();
  }
}

class _MyHomeItemPage extends State<MyMessageItemPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
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

            /*Store.connect<UserModel>(
                builder: (context, UserModel snapshot, child) {
                  return RaisedButton(
                    child: Text('change name'),
                    onPressed: () {
                      snapshot.setUserName("拜仁慕尼黑");
                    },
                  );
                }
            ),*/

            RaisedButton(onPressed: (){
              Store.value<UserModel>(context).setUserName("鸡鸡夫斯基");
            },
              child:Text("点老子"),
              color: Colors.yellowAccent,)

          ],
        )


      ),
    );
  }
}