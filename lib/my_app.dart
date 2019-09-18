
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'fluro/application.dart';
import 'fluro/routes.dart';
import 'provider/index.dart';

void main(){
  // 注册 fluro routes
  Router router =Router();
  Routes.configureRoutes(router);
  Application.router=router;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      /*Provider配置*/
      Store.init(
        context: context,
        child: MaterialApp(
          /*生成路由*/
          onGenerateRoute: Application.router.generator,
        )
      );

  }
}
