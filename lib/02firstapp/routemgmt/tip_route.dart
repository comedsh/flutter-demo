import 'package:flutter/material.dart';

class TipRoute extends StatelessWidget {
  const TipRoute({
    super.key,
    required this.text, // 接收一个text参数
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("提示"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              ElevatedButton(
                onPressed: () => Navigator.pop(
                    context, "我是返回值"), // 通过 pop 返回上一层级；注意，第二个参数是返回值
                child: const Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class RouterTestRoute extends StatelessWidget {
  /// 参数 [isNamedRoute] 用来控制是否使用命名路由
  /// 参数 [isUseQueryParam] 表示是否通过使用 query param 的方式结合 onGestureRoute 的方式来创建目标 Route
  const RouterTestRoute({
    super.key,
    this.isNamedRoute = false,
    this.isUseQueryParam = false,
  });

  final bool isNamedRoute;
  final bool isUseQueryParam;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          String result = '';
          if (!isNamedRoute) {
            // 通过 push 打开 `TipRoute` 页面，通过 result 可以接受从 TipRoute 返回时候所携带的参数
            result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const TipRoute(
                    // 路由参数
                    text: "我是提示xxxx",
                  );
                },
              ),
            );
          } else {
            if (!isUseQueryParam) {
              // 传递参数
              Navigator.pushNamed(
                context,
                "tiproute",
                arguments: <String, String>{
                  'text': 'Berlin',
                },
              );
            } else {
              // 使用 route url param 的方式，通过 OnGestureRoute 方法进行解析出参数
              Navigator.pushNamed(context, "tiproute/Beijing");
            }
          }
          //输出`TipRoute`路由返回结果
          print("路由返回值: $result");
        },
        child: const Text("打开提示页"),
      ),
    );
  }
}
