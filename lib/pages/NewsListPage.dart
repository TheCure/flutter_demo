import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:my_client_app/common/Constants.dart';
import 'package:my_client_app/common/ThemeUtils.dart';
import 'package:my_client_app/common/httpUtil.dart';
import 'package:my_client_app/models/user_bean.dart';
import 'package:my_client_app/widgets/SearchAppBarState.dart';

/*
资讯页面
* */
class NewsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsListPagee();
}

class _NewsListPagee extends State<NewsListPage> {
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
//    getData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  EasyRefreshController _controller;
  List<Forecast> mList = [];

  /*
* 网络请求
* */
  Future<void> getData() async {
    Map<String, dynamic> map = {
      "citykey": 101070101,
    };
    //开始请求
    var response = await HttpUtil().get(Constants.JISUJOKE, data: map);
    if (response.statusCode == 200) {
      //请求体结果response，将数据转化为实体类
      var json = jsonDecode(response.data);
      List list = json["data"]["forecast"] as List;

      mList = list.map((value) {
        return Forecast.fromJson(value);
      }).toList();
      Yesterday.fromJson(json["data"]["yesterday"]);
      mList.add(Forecast("多云", "沈阳", "西南风", "高温 31℃", "21日星期二", "低温 19℃"));
      mList.add(Forecast("多云", "沈阳", "西南风", "高温 31℃", "21日星期二", "低温 19℃"));
      mList.add(Forecast("多云", "沈阳", "西南风", "高温 31℃", "21日星期二", "低温 19℃"));
      mList.add(Forecast("多云", "沈阳", "西南风", "高温 31℃", "21日星期二", "低温 19℃"));
      mList.add(Forecast("多云", "沈阳", "西南风", "高温 31℃", "21日星期二", "低温 19℃"));
      mList.add(Forecast("多云", "沈阳", "西南风", "高温 31℃", "21日星期二", "低温 19℃"));
      _controller.finishRefresh(); // 完成刷新
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          title: Text("资讯", style: TextStyle(color: Colors.white)),
//        ),
        appBar: SearchAppBarState(),
        body: EasyRefresh.custom(
          firstRefresh: true,
          //首次刷新
          firstRefreshWidget: Center(child: CircularProgressIndicator()),
          controller: _controller,
          header: ClassicalHeader(),
          footer: ClassicalFooter(),
          enableControlFinishRefresh: true,
          onRefresh: () async {
            setState(() {
              getData();
            });
          },
//          emptyWidget: Center(child: Text("小猪暂无数据哦亲亲")),
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "风向:" + mList[index].fengxiang,
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        Text("天气:" + mList[index].type),
                        Text("温度:" + mList[index].low),
                        Text("高温:" + mList[index].high),
                      ],
                    ),
                    color:
                        index % 2 == 0 ? Colors.grey[300] : Colors.transparent);
              }, childCount: mList.length),
            ),
          ],
        ));
  }
}
