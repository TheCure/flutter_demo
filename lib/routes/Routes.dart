import 'package:flutter/material.dart';
import 'package:my_client_app/pages/ChangeThemePage.dart';
import 'package:my_client_app/pages/HomePage.dart';
import 'package:my_client_app/pages/login/loginPage.dart';

///
/// des: 路由配置
///
class Routes {
  static const String home_page = '/';
  static const String chang_them_page = 'chang_them_page';
  static const String login_page = 'login_page'; //登录

  static Map<String, WidgetBuilder> routes = {
    home_page: (context) => HomePage(),
    chang_them_page: (context) => ChangeThemePage(),
    login_page: (context) => LoginPage(),
  };
}
