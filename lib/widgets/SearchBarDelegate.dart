import 'package:flutter/material.dart';
import 'package:my_client_app/common/ThemeUtils.dart';
import 'package:my_client_app/common/toastUtils.dart';

class SearchBarDelegate extends SearchDelegate {
  //数据内容
  final List list = [
    "aa-线的高度",
    "aa-高度",
    "bb-分割线前面空白区域",
    "cc-分割线后面空白区域",
    'dd-是控件的高',
    "gg22-bdfaw",
    "gg333-lajd"
  ];
  final rege = [
    "推荐-1",
    "推荐-2",
    "推荐-3",
    "推荐-4",
    "推荐-5",
    "推荐-6",
  ];

  /*
  *页面搜索框右上角显示内容方法
  * return组件内容
  * */
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      //放置按钮，点击时，将搜索框清空
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.black,
        ),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  /*
  *页面搜索框左上角显示返回按钮方法
  * return组件
  * */
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      //返回动态按钮
      icon: AnimatedIcon(
        color: Colors.black,
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        //回调中调用close方法，关闭搜索页面
        close(context, null);
      },
    );
  }

  /*
  *点击键盘确认后显示的内容
  * return组件
  * */
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      //点击确认后会关闭搜索页面，并显示如下组件内容
      width: 100,
      height: 100,
      child: Card(
        color: Colors.brown,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  /*
  *输入框下方的显示内容，一般为辅助内容列表，内容改变重复调用
  *
  * */
  @override
  Widget buildSuggestions(BuildContext context) {
    //输入框内容为空，数据数组为rege，后面ListView.builder动态生成
    //输入框不为空时,利用数组.where()过滤器,返回满足将输入内容作为开头的数组中的字符串,再toList方法转换成数组
    final sugList = query.isEmpty
        ? rege
        : list.where((input) => input.startsWith(query)).toList();

    //调用动态列表生成数据
    return ListView.separated(
        itemBuilder: (context, index) => InkWell(
            onTap: () {
              ToastUtils.showToast(sugList[index].toString());
            },
            child: ListTile(
              //利用富文本组件,将字符串变成可以设置各个片段样式以及事件的字符串
              title: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      //截取数组中的每条字符串输入内容长度之后的字符，并修改其样式
                      text: sugList[index].substring(0, query.length),
                      style: TextStyle(color: ThemeUtils.currentColorTheme)),
                  TextSpan(
                      //截取数组中的每条字符串输入内容长度之后的字符，并修改其样式
                      text: sugList[index].substring(query.length),
                      style: TextStyle(color: Colors.black))
                ]),
              ),
            )),
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: ThemeUtils.text_cccccc,
            height: 0.5,
          );
        },
        itemCount: sugList.length);
  }
}
