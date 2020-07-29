import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_client_app/common/ThemeUtils.dart';
import 'package:my_client_app/common/screenUtil.dart';
import 'package:my_client_app/common/toastUtils.dart';
import 'package:my_client_app/widgets/SearchAppBarState.dart';

import 'home_item/home_gridview_item.dart';

/*
动弹页面
* */
class TweetsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TweetsListPage();
}

class _TweetsListPage extends State<TweetsListPage>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<TweetsListPage> {
  ScrollController _scrollViewController;
  TabController _controller;
  List<Tab> _tabModels = [];
  List<String> _text = [
    "天猫",
    "聚划算",
    "天猫国际",
    "外卖",
    "天猫超市",
    "充值中心",
    "飞猪旅行",
    "领金币",
    "拍卖",
    "分类"
  ];
  Size _sizeRed;
  GlobalKey _keyFilter = GlobalKey();
  List _swiperDataList = [
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595934043096&di=51c28063e9c02ca2eacd56a34cb8f19b&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Fb6e962f733ab8b567e04a5f66f1517959cb946613c01b-HLTlZT_fw658",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595934021388&di=dd5de25df0ddf1d602217c9df11b1a0a&imgtype=0&src=http%3A%2F%2Fimg.51miz.com%2FElement%2F00%2F94%2F35%2F39%2F0f62176e_E943539_ca8732c4.jpg%2521%2Fquality%2F90%2Funsharp%2Ftrue%2Fcompress%2Ftrue%2Fformat%2Fjpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595933779463&di=e0d59e1c0872eb99bc40bb383b41979d&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F823dd71e85f4394d74c7d82b4513a1834597925923231-jZNh7r_fw658"
  ];
  var index = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 6, vsync: this);
    _controller.addListener(() {
      index = _controller.index;
      setState(() {});
    });
    _scrollViewController = ScrollController();
    _tabModels.add(Tab(
        child: Container(
      color: Colors.white,
      child: Text("全部"),
    )));
//    _tabModels.add(Tab(text: '全部'));
    _tabModels.add(Tab(text: '直播'));
    _tabModels.add(Tab(text: '便宜好货'));
    _tabModels.add(Tab(text: '买家秀'));
    _tabModels.add(Tab(text: '全球'));
    _tabModels.add(Tab(text: '母婴'));
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  _afterLayout(_) {
    _getPositions('_keyFilter', _keyFilter);
  }

  _getPositions(log, GlobalKey globalKey) {
    RenderBox renderBoxRed = globalKey.currentContext.findRenderObject();
    var positionRed = renderBoxRed.localToGlobal(Offset.zero);
    _sizeRed = renderBoxRed.size;
    setState(() {});
    print("POSITION of $log: $positionRed ");
    print("SIZE of $log: $_sizeRed");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _scrollViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var flexible_list = Column(
      key: _keyFilter,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildAdvertisingWidget(),
        _buildGridWidget(),
      ],
    );
    var body = NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: ThemeUtils.text_f9f9f9,
              pinned: true,
              floating: true,
//              expandedHeight: 300,
              expandedHeight: (_sizeRed == null
                      ? ScreenUtil.screenHeight
                      : _sizeRed.height) +
                  50.0,
              // 这个高度必须比flexibleSpace高度大
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(background: flexible_list),
              bottom: PreferredSize(
                preferredSize: Size(double.infinity, 48),
                child: Container(
                  color: Colors.white,
                  child: TabBar(
                    indicatorColor: Colors.transparent,
                    isScrollable: true,
                    labelColor: Colors.red,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    unselectedLabelColor: Colors.black,
                    unselectedLabelStyle:
                        TextStyle(fontWeight: FontWeight.normal),
                    controller: _controller,
                    tabs: _tabModels
                        .map((e) => Container(
                              child: e,
                            ))
                        .toList(),
                  ),
                ),
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _controller,
          children: _resultListPages(),
        )
    );

    return Scaffold(
        appBar: SearchAppBarState(),
        body: Column(
          children: <Widget>[
            Offstage(
              offstage: true,
              child: Container(
                child: flexible_list,
                key: _keyFilter,
              ),
            ),
            Expanded(child: body),
          ],
        ));
  }

/*
* 顶部轮播图
* */
  Widget _buildAdvertisingWidget() {
    return Container(
        height: 120,
        child: Swiper(
          itemCount: 3,
          loop: true,
          autoplay: true,
          pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(size: 6, activeSize: 6)),
          itemBuilder: (BuildContext context, int index) {
            return new Image.network(
              _swiperDataList[index],
              fit: BoxFit.fill,
            );
          },
        ));
  }

  Widget _buildGridWidget() {
    return Container(
      height: 160,
      child: Swiper(
        itemCount: 2,
        // 无限轮播模式开关
        loop: false,
        // 设置 new SwiperPagination() 展示默认分页指示器
        pagination: SwiperPagination(
            builder: RectSwiperPaginationBuilder(
                color: Colors.black12,
                size: Size(18, 3),
                activeSize: Size(18, 3),
                space: 0)),
        itemBuilder: (BuildContext context, int index) {
          return GridView.custom(
            shrinkWrap: true,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
            childrenDelegate: SliverChildBuilderDelegate(
              (context, position) {
                return GestureDetector(
                  onTap: () {
                    ToastUtils.showToast('你点击了第$index页的第$position个');
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(180.0),
                          child: Image.asset(
                            "imgs/2.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                        Text(
                          _text[position],
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: index == 0 ? 10 : 4,
            ),
          );
        },
      ),
    );
  }

/*
* tabbarview列表
* */
  List<Widget> _resultListPages() {
    List<Widget> pages = [];
    for (var i = 0; i < 6; ++i) {
      var page = HomeGridViewItem(
        controller: _controller,
      );
      pages.add(page);
    }
    return pages;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
