import 'package:flutter/material.dart';
import 'package:my_client_app/common/Constants.dart';
import 'package:my_client_app/common/DataUtils.dart';
import 'package:my_client_app/common/ThemeUtils.dart';
import 'package:my_client_app/events/ChangeThemeEvent.dart';
import 'package:my_client_app/routes/Routes.dart';

import 'ChangeThemePage.dart';
import 'DiscoveryPage.dart';
import 'MyInfoPage.dart';
import 'NewsListPage.dart';
import '../widgets/SearchBarDelegate.dart';
import 'TweetsListPage.dart';

/*
*
* 首页
* */
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeContentPage();
  }
}

class _HomeContentPage extends State<HomePage> {
  int _index = 0;
  List<Widget> _pages;
  var _title = ['资讯', '动弹', '发现', '我的'];

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      NewsListPage(),
      TweetsListPage(),
      DiscoveryPage(),
      MyInfoPage()
    ];
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: PreferredSize(
//          child: Container(
//            width: double.infinity,
//            height: double.infinity,
//            decoration: BoxDecoration(
//                gradient: LinearGradient(colors: [Colors.yellow, Colors.pink])),
//            child: SafeArea(child: Text("1212")),
//          ),
//          preferredSize: Size(double.infinity, 60)),
      body: Center(
        child: IndexedStack(
          index: _index,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        unselectedItemColor: Colors.black,
        selectedItemColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_view_day), title: Text(_title[0])),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time), title: Text(_title[1])),
          BottomNavigationBarItem(
              icon: Icon(Icons.satellite), title: Text(_title[2])),
          BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit), title: Text(_title[3]))
        ],
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}
