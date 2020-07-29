import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class DataUtils {
  static const String SP_AC_TOKEN = "accessToken";
  static const String SP_UID = "uid";
  static const String SP_IS_LOGIN = "isLogin"; //是否登录
  static const String SP_PASSWORD = "password"; //密码
  static const String SP_PHONE = "phone"; //手机号

  static const String SP_COLOR_THEME_INDEX = "colorThemeIndex";

  // 保存用户登录信息，data中包含了账号密码等信息
  static saveLoginInfo(Map data) async {
    if (data != null) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String phone = data['phone'];
      await sp.setString(SP_PHONE, phone);
      String password = data['password'];
      await sp.setString(SP_PASSWORD, password);
      await sp.setBool(SP_IS_LOGIN, true);
    }
  }

  // 清除登录信息
  static clearLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(SP_PHONE, "");
    await sp.setString(SP_PASSWORD, "");
    await sp.setBool(SP_IS_LOGIN, false);
  }

  // 是否登录
  static Future<bool> isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool b = sp.getBool(SP_IS_LOGIN);
    return b != null && b;
  }

  // 获取accesstoken
  static Future<String> getAccessToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(SP_AC_TOKEN);
  }

  // 设置选择的主题色
  static setColorTheme(int colorThemeIndex) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt(SP_COLOR_THEME_INDEX, colorThemeIndex);
  }

  static Future<int> getColorThemeIndex() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt(SP_COLOR_THEME_INDEX);
  }
//  // 保存用户个人信息
//  static Future<UserInfo> saveUserInfo(Map data) async {
//    if (data != null) {
//      SharedPreferences sp = await SharedPreferences.getInstance();
//      String name = data['name'];
//      num id = data['id'];
//      String gender = data['gender'];
//      String location = data['location'];
//      String avatar = data['avatar'];
//      String email = data['email'];
//      String url = data['url'];
//      await sp.setString(SP_USER_NAME, name);
//      await sp.setInt(SP_USER_ID, id);
//      await sp.setString(SP_USER_GENDER, gender);
//      await sp.setString(SP_USER_AVATAR, avatar);
//      await sp.setString(SP_USER_LOC, location);
//      await sp.setString(SP_USER_EMAIL, email);
//      await sp.setString(SP_USER_URL, url);
//      UserInfo userInfo = UserInfo(
//          id: id,
//          name: name,
//          gender: gender,
//          avatar: avatar,
//          email: email,
//          location: location,
//          url: url);
//      return userInfo;
//    }
//    return null;
//  }
//
//  // 获取用户信息
//  static Future<UserInfo> getUserInfo() async {
//    SharedPreferences sp = await SharedPreferences.getInstance();
//    bool isLogin = sp.getBool(SP_IS_LOGIN);
//    if (isLogin == null || !isLogin) {
//      return null;
//    }
//    UserInfo userInfo = UserInfo();
//    userInfo.id = sp.getInt(SP_USER_ID);
//    userInfo.name = sp.getString(SP_USER_NAME);
//    userInfo.avatar = sp.getString(SP_USER_AVATAR);
//    userInfo.email = sp.getString(SP_USER_EMAIL);
//    userInfo.location = sp.getString(SP_USER_LOC);
//    userInfo.gender = sp.getString(SP_USER_GENDER);
//    userInfo.url = sp.getString(SP_USER_URL);
//    return userInfo;
//  }

}
