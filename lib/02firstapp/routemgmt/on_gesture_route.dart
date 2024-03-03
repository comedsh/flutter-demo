import "package:flutter/material.dart";
import "tip_route.dart";

/// https://book.flutterchina.club/chapter2/flutter_router.html#_2-4-6-%E8%B7%AF%E7%94%B1%E7%94%9F%E6%88%90%E9%92%A9%E5%AD%90
/// 最重要的是：当调用Navigator.pushNamed(...)打开命名路由时，如果命名路由中没有注册，那么会使用 onGenerateRoute 回调方法来创建路由，因此
/// 这里我们就不注册 TipRoute 的路由了，而是通过 onGenerateRoute 方法生成
class OnGestureRouterApp extends StatelessWidget {
  const OnGestureRouterApp({super.key});

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
        "/": (context) => const RouterTestRoute(isNamedRoute: true, isUseQueryParam: true), // 设置使用 url param 的方式
      },
      onGenerateRoute:(RouteSettings settings) {
        // Handle /tiproute/:text
        var uri = Uri.parse(settings.name!);
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'tiproute') {
          String text = uri.pathSegments[1];  // 解析出 url param
          return MaterialPageRoute(
            builder: (context) => TipRoute(
              text: text,  // 然后将 url param 参数传入
            ),
          );
        }
        
        throw Exception('No route found');
      }
    );
  }
}
