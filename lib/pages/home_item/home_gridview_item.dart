import 'package:flutter/material.dart';
import 'package:my_client_app/common/ThemeUtils.dart';

class HomeGridViewItem extends StatefulWidget {
  final TabController controller;
  final int index;

  @override
  _HomeItemPage createState() {
    return _HomeItemPage();
  }

  HomeGridViewItem({Key key, this.controller, this.index}) : super(key: key);
}

class _HomeItemPage extends State<HomeGridViewItem>
    with AutomaticKeepAliveClientMixin<HomeGridViewItem> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("sdj-${widget.controller.index}");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("sdjj-${widget.controller.index}");
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        //禁用滑动事件
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 4.0, //水平子 Widget 之间间距
            mainAxisSpacing: 5.0, //垂直子 Widget 之间间距
            crossAxisCount: 2, //一行的 Widget 数量
            childAspectRatio: 1 / 1.4),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(5.0)),
            ),
            child: Column(
              children: [
                //图片
                Container(
                  height: 120.0,
                  decoration: BoxDecoration(
                      borderRadius:
                          new BorderRadius.vertical(top: Radius.circular(5.0)),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2082848815,1382311806&fm=26&gp=0.jpg"),
                          fit: BoxFit.cover)),
                ),
                //标题
                Container(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    "图片加载较慢，会有卡顿，而非APP卡顿，可以滑到下面直接看示例图片看示例图片可以滑到下面直接看示例图片看示例图片可以滑到下面直接看示例图片看示例图片",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                //标签
                _lable(),
                _price(),
              ],
            ),
          );
        },
      ),
    );
  }

/*
* 标签
* */
  _lable() {
    return Container(
      padding: EdgeInsets.only(left: 5.0),
      child: Row(
        children: [
          Container(
            child: Text(
              "满300减30",
              maxLines: 2,
              style: TextStyle(color: Colors.red, fontSize: 12.0),
              overflow: TextOverflow.ellipsis,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 1),
              borderRadius: BorderRadius.all((Radius.circular(5))),
            ),
            padding: EdgeInsets.only(left: 3.0, right: 3.0),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text(
              "包邮",
              maxLines: 2,
              style: TextStyle(color: Colors.amberAccent, fontSize: 12.0),
              overflow: TextOverflow.ellipsis,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.amberAccent, width: 1),
              borderRadius: BorderRadius.all((Radius.circular(5))),
            ),
            padding: EdgeInsets.only(left: 3.0, right: 3.0),
          ),
        ],
      ),
    );
  }

  _price() {
    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 10),
      child: Row(
        children: [
          Container(
            child: Text(
              "￥128",
              maxLines: 2,
              style: TextStyle(color: Colors.red, fontSize: 18.0),
              overflow: TextOverflow.ellipsis,
            ),
            padding: EdgeInsets.only(left: 3.0, right: 3.0),
          ),
          Container(
            child: Text(
              "1920人评价",
              maxLines: 2,
              style: TextStyle(color: ThemeUtils.text_999999, fontSize: 12.0),
              overflow: TextOverflow.ellipsis,
            ),
            padding: EdgeInsets.only(left: 3.0, right: 3.0),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.more_horiz,
                color: ThemeUtils.text_999999,
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
