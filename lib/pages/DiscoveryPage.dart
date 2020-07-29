import 'package:flutter/material.dart';

/*
发现页面
* */
class DiscoveryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DiscoveryPage();
}

class _DiscoveryPage extends State<DiscoveryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title:Text( "发现",style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        child: Text("ss"),
      ),
    );
  }
}
