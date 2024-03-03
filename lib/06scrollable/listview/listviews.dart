import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class ListView2 extends StatelessWidget {
  const ListView2({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: ListView.builder(
            itemCount: 100, // 指定列表的长度
            itemExtent: 50.0, //强制高度为50.0
            itemBuilder: (BuildContext context, int index) {
              return ListTile(title: Text("$index"));
            }));
  }
}

/// ListView.separated可以在生成的列表项之间添加一个分割组件，它比ListView.builder多了一个separatorBuilder参数，该参数是一个分割组件生成器。
class ListView3 extends StatelessWidget {
  const ListView3({super.key});

  @override
  Widget build(BuildContext context) {
    //下划线widget预定义以供复用。
    Widget divider1 = const Divider(
      color: Colors.blue,
    );
    Widget divider2 = const Divider(color: Colors.green);

    return Material(
      child: ListView.separated(
        itemCount: 100,
        //列表项构造器
        itemBuilder: (BuildContext context, int index) {
          return ListTile(title: Text("$index"));
        },
        //分割器构造器
        separatorBuilder: (BuildContext context, int index) {
          return index % 2 == 0 ? divider1 : divider2;
        },
      ),
    );
  }
}

/// 前面说过，给列表指定 itemExtent 或 prototypeItem 会有更高的性能，所以当我们知道列表项的高度都相同时，
/// 强烈建议指定 itemExtent 或 prototypeItem
class FixedExtentList extends StatelessWidget {
  const FixedExtentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        // 没有指定 itemCount 则是一个无限列表
        child: ListView.builder(
          // 因为列表项都是一个 ListTile，高度相同，但是我们不知道 ListTile 的高度是多少，所以指定了 prototypeItem
          // 指定 prototypeItem 后，可滚动组件会在 layout 时计算一次它延主轴方向的长度，这样也就预先知道了所有列表项的延主轴方向的长度
          // 所以和指定 itemExtent 一样，指定 prototypeItem 会有更好的性能
          prototypeItem: const ListTile(title: Text("1")),
          //itemExtent: 56,
          itemBuilder: (context, index) {
            // LayoutLogPrint是一个自定义组件，在布局时可以打印当前上下文中父组件给子组件的约束信息
            // 注意，这是作者的 flukit 组件库所提供的，需要安装
            // 输出： flutter: 256: BoxConstraints(w=430.0, h=56.0)  这样我们就可以知道组件的具体高度了
            return LayoutLogPrint(
              tag: index,
              child: ListTile(title: Text("$index")),
            );
          },
        )
    );
  }
}

/// 6.3.6 中最后一小节内容：如何设置固定的表头
class FixHeadList extends StatelessWidget {
  const FixHeadList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('测试'),            
      ),
      body: Column(children: <Widget>[
        const ListTile(title: Text("商品列表")),
        Expanded(
          child: ListView.builder(itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text("$index"));
          }),
        ),
      ]),
    );
  }

}
