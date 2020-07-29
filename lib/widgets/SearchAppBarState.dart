import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_client_app/widgets/slideTransitionX.dart';

import 'SearchBarDelegate.dart';

class SearchAppBarState extends StatelessWidget implements PreferredSizeWidget {
  SearchAppBarState({
    Key key,
    this.leading,
    this.title,
    this.hintText,
    this.onCancel,
    this.onSearch,
  }) : super(key: key);
  final Widget leading;

  // 标题
  final String title;

  final String hintText;

  // 点击取消回调
  final VoidCallback onCancel;

  // 点击键盘搜索回调
  final ValueChanged<String> onSearch;

  @override
  Widget build(BuildContext context) {
    return _AppBar(
      key: key,
      leading: leading,
      title: title,
      hintText: hintText,
      onSearch: onSearch,
      onCancel: onCancel,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBar extends StatefulWidget {
  _AppBar({
    Key key,
    this.leading,
    this.title,
    this.hintText,
    this.onCancel,
    this.onSearch,
  }) : super(key: key);

  // 头部组件 可选
  final Widget leading;

  // 标题 可选
  final String title;

  final String hintText;

  // 点击取消回调 可选
  final VoidCallback onCancel;

  // 点击键盘搜索回调 可选
  final ValueChanged<String> onSearch;

  @override
  _AppBarState createState() => _AppBarState();
}

class _AppBarState extends State<_AppBar> {
  TextEditingController _controller = TextEditingController();
  bool _showSearch = false; // 显示搜索框

  @override
  void dispose() {
    _controller?.dispose();
    timer.cancel();
    super.dispose();
  }

  List _count = ["乘风破浪的姐姐", "美妆教程日常化妆", "乘风破浪的姐姐|美妆教程日常化妆"];
  int index = 0;
  static const duration = const Duration(seconds: 3);
  Timer timer;

  // 搜索面板 默认返回标题
  Widget _searchPanel() {
    if (timer == null) {
      //计时器
      timer = Timer.periodic(duration, (Timer t) {
        setState(() {
          if (index == 2) {
            timer.cancel();
          } else {
            index = index + 1; //需要更新UI
          }
        });
      });
    }
    return Container(
        alignment: Alignment.center,
        margin:
            EdgeInsets.only(left: 10.0, right: 10.0, top: kToolbarHeight / 2),
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
                child: InkWell(
              //搜索
              onTap: () {
                showSearch(context: context, delegate: SearchBarDelegate());
              },
              child: Container(
                height: 40.0,
                margin: EdgeInsets.only(right: 10.0),
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(30.0),
                  color: Colors.white,
                ),
                padding: EdgeInsets.only(left: 15.0),
                alignment: Alignment.centerLeft,
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.search, color: Colors.black26),
                    Text(
                      _count[index].toString(),
                    ),
//                  AnimatedSwitcher(
//                    duration: Duration(seconds: 1),
//                    transitionBuilder:
//                        (Widget child, Animation<double> animation) {
//                      if (timer == null) {
//                        //计时器
//                        timer = Timer.periodic(duration, (Timer t) {
//                          setState(() {
//                            if (index == 2) {
////                            timer.cancel();
//                              index = 0;
//                            } else {
//                              index = index + 1; //需要更新UI
//                            }
//                          });
//                        });
//                      }
//                      return SlideTransitionX(
//                        child: child,
//                        direction: AxisDirection.up, //上入下出
//                        position: animation,
//                      );
//                    },
////                    child: Container(
////                      height: 39,
////                      alignment: Alignment.centerLeft,
////                        child: Text(
////                          _count[index].toString(),
////                          //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
////                          key: ValueKey<int>(index),
////                        ) ,
////                    )
//                    child: Text(
//                      _count[index].toString(),
//                      //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
//                      key: ValueKey<int>(index),
//                    ),
//                  ),
                  ],
                ),
              ),
            )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.camera_enhance,
                  color: Colors.white,
                ),
                Text(
                  "发布", style: TextStyle(color: Colors.white, fontSize: 12.0),
                  //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                ),
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AppBar(
          brightness: Brightness.dark,
          leading: widget.leading,
          elevation: 0,
        ),
        _searchPanel(),
      ],
    );
//    return AppBar(
//      leading: widget.leading,
//      title: _searchPanel(),
//      elevation: 0,
//      backgroundColor: Color.fromARGB(0, 0, 375, 70),
//    );
  }
}
