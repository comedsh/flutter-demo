import "package:flutter/material.dart";
import "tip_route.dart";

class NamedRouterApp extends StatelessWidget {
  const NamedRouterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/", // 名为 "/" 的路由作为应用的起始页即 home 页面
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //注册路由表
      routes: {
        "tiproute": (context) {
          // 动态的去解析并获取参数
          final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
          String text = arguments['text'];          
          return TipRoute(text: text);
        },
        "/": (context) => const RouterTestRoute(isNamedRoute: true), // 注册首页路由，并告诉它使用命名路由的方式
      },
    );
  }
}
