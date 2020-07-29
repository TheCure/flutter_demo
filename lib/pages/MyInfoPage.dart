import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_client_app/common/Constants.dart';
import 'package:my_client_app/common/DataUtils.dart';
import 'package:my_client_app/common/ThemeUtils.dart';
import 'package:my_client_app/common/toastUtils.dart';
import 'package:my_client_app/events/ChangeThemeEvent.dart';
import 'package:my_client_app/routes/Routes.dart';

import '../widgets/SearchBarDelegate.dart';

/*
* 我的页面
* */
class MyInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyInfoPage();
  }
}

class _MyInfoPage extends State<MyInfoPage> {
  var titles = ["切换主题", "阅读记录", "我的博客", "我的问答", "我的活动", "我的设置"];
  var _icon = [
    Icons.collections,
    Icons.payment,
    Icons.photo_album,
    Icons.schedule,
    Icons.event_available,
    Icons.settings
  ];
  var _color = [
    Colors.redAccent,
    Colors.green,
    Colors.blue,
    Colors.amberAccent,
    Colors.orangeAccent,
    Colors.lime
  ];
  Color themeColor = ThemeUtils.currentColorTheme;
  var _colorSubscription;

  @override
  void initState() {
    super.initState();
    _colorSubscription =
        Constants.eventBus.on<ChangeThemeEvent>().listen((event) {
      setState(() {
        themeColor = event.color;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    //取消订阅
    _colorSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          elevation: 0,
          title: Text('我的', style: TextStyle(color: Colors.white)),
        ),
        body: Flex(
          direction: Axis.vertical,
          children: <Widget>[
//            Divider(height: 0.1,thickness:  0.1,color: Colors.black12),
            InkWell(
              onTap: () {
                DataUtils.isLogin().then((index) {
                  print('color theme index = $index');
                  if (index == true) {
                    ToastUtils.showToast("未完善", gravity: ToastGravity.CENTER);
                  } else {
                  Navigator.pushNamed(context, Routes.login_page);
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.all(15),
                color: themeColor,
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.asset(
                        "imgs/2.png",
                        fit: BoxFit.fill,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                      height: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "亲密爱人",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            margin: EdgeInsets.only(bottom: 5),
                          ),
                          Text(
                            "今夜还吹着风 想起你好温柔",
                            style:
                                TextStyle(color: Colors.black45, fontSize: 14),
                          ),
                        ],
                      ),
                    )),
                    Icon(Icons.supervisor_account),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemBuilder: (context, i) => renderRow(i),
                itemCount: titles.length ,
              ),
            )
          ],
        ));
  }

/*
* item列表布局
* */
  renderRow(i) {
    var listItemContent = Container(
      color: Colors.white,
      child: ListTile(
        title: Text(titles[i]),
        trailing: Icon(Icons.chevron_right),
        leading: Icon(
          _icon[i],
          color: _color[i],
        ),
      ),
    );
    return InkWell(
      child: listItemContent,
      onTap: () {
        if (i == 0) Navigator.pushNamed(context, Routes.chang_them_page);
        if (i == 1) showSearch(context: context, delegate: SearchBarDelegate());
        if (i == 5) DataUtils.clearLoginInfo();
      },
    );
  }
}
