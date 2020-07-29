import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final List<String> tabModels;
  final TabController tabController;
  final int currentIndex;
  const TabBarWidget({Key key, this.tabModels, this.tabController, this.currentIndex}) : super(key: key);

  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(30);
}

class _TabBarWidgetState extends State<TabBarWidget> {
//  get preferredSize {
//    return Size.fromHeight(60);
//  }
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
//      width: MediaQuery.of(context).size.width,
      child: TabBar(
          controller: widget.tabController,
          indicatorColor: Colors.transparent,
          isScrollable: true,
          labelColor: Colors.red,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelColor: Colors.black,
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
          onTap: (i) {
            _selectedIndex = i;
            setState(() {});
          },
          tabs: widget.tabModels
              .map((i) => Container(
            height: 44.0,
            child: new Tab(
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 3,
                        ),
                        Text(i),
                        SizedBox(
                          height: 3,
                        ),
                        widget.tabModels.indexOf(i) == widget.currentIndex
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            color: Color(0xFFfe5100),
                            child: Text(
                              i,
                              style: TextStyle(fontSize: 9, color: Colors.white),
                            ),
                          ),
                        )
                            : Expanded(
                          child: Text(
                            i,
                            style: TextStyle(fontSize: 9, color: Color(0xFFb5b6b5)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: Color(0xFFc9c9ca),
                    )
                  ],
                )),
          ))
              .toList()),
    );
  }
}
