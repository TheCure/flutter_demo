import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_client_app/common/ThemeUtils.dart';
import 'package:my_client_app/common/screenUtil.dart';
import 'package:my_client_app/common/toastUtils.dart';
import 'package:my_client_app/widgets/SearchAppBarState.dart';
import 'package:my_client_app/widgets/my_underline_tabIndicator.dart';

import 'home_item/home_gridview_item.dart';

/*
动弹页面
* */
class TweetsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TweetsListPage();
}

class _TweetsListPage extends State<TweetsListPage>
    with TickerProviderStateMixin {
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
    "http://img.haote.com/upload/20180918/2018091815372344164.jpg",
    "http://img.haote.com/upload/20180918/2018091815372344164.jpg",
    "http://img.haote.com/upload/20180918/2018091815372344164.jpg",
    "http://img.haote.com/upload/20180918/2018091815372344164.jpg",
    "http://img.haote.com/upload/20180918/2018091815372344164.jpg",
  ];
  var isShow = false; //底部悬浮按钮是否显示

  @override
  void initState() {
    super.initState();
    //tabBar和tabBarView的滑动监听，滑动获取当前下标
    _controller = TabController(length: 4, vsync: this);
    //NestedScrollView的滑动监听，滑动到底部悬浮按钮显示
    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.pixels ==
              _scrollViewController.position.maxScrollExtent &&
          isShow != true) {
        setState(() {
          isShow = true;
        });
      } else if (_scrollViewController.position.pixels !=
              _scrollViewController.position.maxScrollExtent &&
          isShow != false) {
        setState(() {
          isShow = false;
        });
      }
    });
    //tabBar数据
    _tabModels.add(Tab(text: '全部'));
    _tabModels.add(Tab(text: '直播'));
    _tabModels.add(Tab(text: '便宜好货'));
    _tabModels.add(Tab(text: '买家秀'));
    //在元素渲染完成时获取元素大小，这个方法在一帧的最后调用，并且只调用一次。
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  _afterLayout(_) {
    _getPositions('_keyFilter', _keyFilter);
  }

/*
* 获取可滑出部分的高度
* */
  _getPositions(log, GlobalKey globalKey) {
    RenderBox renderBoxRed = globalKey.currentContext.findRenderObject();
    var positionRed = renderBoxRed.localToGlobal(Offset.zero); //元素的位置
    _sizeRed = renderBoxRed.size; //元素大小
    setState(() {});
    print("SIZE of $log: $_sizeRed");
  }

  @override
  void dispose() {
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

    var body = NestedScrollViewRefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[_sliverAppBar(flexible_list)];
        },
        pinnedHeaderSliverHeightBuilder: () {
          //解决TabBar覆盖住TabBarView
          return 50;
        },
        // 第二步 在innerScrollPositionKeyBuilder回调中获取当前的选项卡键。该密钥应与步骤1中给出的相同
        //解决NestedScrollView嵌套tabview同步的内部滚动条
        innerScrollPositionKeyBuilder: () {
          String index = 'Tab';
          index += _controller.index.toString();
          return Key(index);
        },
        body: Expanded(
          child: TabBarView(
            controller: _controller,
            children: _resultListPages(),
          ),
        ),
      ),
    );

    return Scaffold(
        appBar: SearchAppBarState(),
        body: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
          Column(
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
          ),
          //悬浮按钮
          Container(
            margin: EdgeInsets.only(bottom: 20.0, right: 10.0),
            child: isShow
                ? FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(Icons.arrow_upward),
                    onPressed: () {
                      _scrollViewController..position.jumpTo(0);
                    },
                  )
                : null,
          )
        ]));
  }

/*
*
* 可滑出部分视图
* */
  _sliverAppBar(Widget flexible_list) {
    return SliverAppBar(
//              primary: false,
      backgroundColor: ThemeUtils.text_f9f9f9,
      //是否固定在顶部
      pinned: true,
      //设置为true时，向下滑动时，即使当前CustomScrollView不在顶部，SliverAppBar也会跟着一起向下出现
      floating: true,
//              snap: true,//与floating结合使用，当手指放开时，SliverAppBar会根据当前的位置进行调整，始终保持展开或收起的状态，此效果在floating=true时生效
      elevation: 0.0,
//              expandedHeight: 300,
      //展开区域的高度
      expandedHeight:
          (_sizeRed == null ? 0.0 : _sizeRed.height) + 50,
//      // 这个高度必须比flexibleSpace高度大
//      forceElevated: innerBoxIsScrolled,
      //展开和折叠区域
      flexibleSpace: FlexibleSpaceBar(background: flexible_list),
      //底部控件
      bottom: PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: Container(
          color: Colors.white,
          child: TabBar(
            indicator: MyUnderlineTabIndicator(
                borderSide: BorderSide(
                    width: 2.0, color: Theme.of(context).primaryColor)),
            indicatorColor: Theme.of(context).primaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Theme.of(context).primaryColor,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.black,
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            controller: _controller,
            tabs: _tabModels
                .map((e) => Center(
                      child: e,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

/*
* 顶部轮播图
* */
  Widget _buildAdvertisingWidget() {
    return Container(
        height: 120,
        child: Swiper(
          itemCount: 5,
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

/*
* GridView轮播
* */
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
            physics: NeverScrollableScrollPhysics(),
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
//                          borderRadius: BorderRadius.circular(180.0),
                          child: position % 2 == 0
                              ? Icon(
                                  Icons.satellite,
                                  color: Theme.of(context).primaryColor,
                                  size: 30.0,
                                )
                              : Icon(
                                  Icons.add_a_photo,
                                  color: Colors.deepOrangeAccent,
                                  size: 30.0,
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

  List<Widget> pages = [];

/*
* tabbarview列表
* */
  List<Widget> _resultListPages() {
    //避免多次加载
    if (pages.length == 0) {
      for (var i = 0; i < 4; ++i) {
        var page;
        switch (i) {
          case 1: //第一步 将列表在tabview中放入NestedScrollViewInnerScrollPositionKeyWidget，并获得唯一的密钥，，例如Tab1
            page = NestedScrollViewInnerScrollPositionKeyWidget(
                Key("Tab1"), HomeGridViewItem(index: i, num: 3));
            break;
          case 2:
            page = NestedScrollViewInnerScrollPositionKeyWidget(
                Key("Tab2"), HomeGridViewItem(index: i, num: 4));
            break;
          case 3:
            page = NestedScrollViewInnerScrollPositionKeyWidget(
                Key("Tab3"), HomeGridViewItem(index: i, num: 10));
            break;
          default:
            page = NestedScrollViewInnerScrollPositionKeyWidget(
                Key("Tab0"), HomeGridViewItem(index: i, num: 10));
            break;
        }
        pages.add(page);
      }
    }
    return pages;
  }
}
