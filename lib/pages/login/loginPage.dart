import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_client_app/common/DataUtils.dart';
import 'package:my_client_app/common/ThemeUtils.dart';
import 'package:my_client_app/common/toastUtils.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Loginpage();
}

class _Loginpage extends State<LoginPage> {
//手机号的控制器
  TextEditingController phoneController;

  //密码的控制器
  TextEditingController passController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    passController = TextEditingController();
    phoneController.addListener(() {
      visiBut();
    });
    passController.addListener(() {
      visiBut();
    });
  }

/*判断按钮是否可以点击*/
  void visiBut() {
    if (phoneController.text.length != 11 ||
        phoneController.text[0] != "1" ||
        passController.text.length < 6) {
      bag_Color = Colors.black26;
      isLogin = false;
    } else {
      bag_Color = ThemeUtils.currentColorTheme;
      isLogin = true;
    }
    setState(() {});
  }

  Color bag_Color = Colors.black26; //登录按钮颜色
  bool isLogin = false; //是否可以登录

  @override
  void dispose() {
    super.dispose();
    passController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("登录", style: TextStyle(color: Colors.black)),
        elevation: 0.0,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        brightness: Brightness.light, //状态栏颜色
      ),
      body: SingleChildScrollView(
          child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50.0),
            child: Center(
              child: Text(
                "登录后更精彩",
                style: TextStyle(fontSize: 25.0),
              ),
            ),
          ),
          Container(
//              color: Colors.black,
            margin: EdgeInsets.only(top: 15.0, left: 30.0, right: 30.0),
            child: TextField(
              controller: phoneController,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly //只允许输入数字
              ],
              textAlignVertical: TextAlignVertical.center,
              textInputAction: TextInputAction.next,
              style: TextStyle(fontSize: 20.0, color: Colors.black),
              //光标宽
              cursorWidth: 1,
              //设置输入类型，不同的输入类型键盘不一样
              keyboardType: TextInputType.phone,
              maxLength: 11,
              //自动对焦
              autofocus: true,
              decoration: _inputDecotation("请输入手机号", true),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30.0, right: 30.0),
            child: TextField(
              controller: passController,
              inputFormatters: [
                //只允许输入字母和数字   汉字[\u4e00-\u9fa5]
                WhitelistingTextInputFormatter(RegExp("[a-zA-Z]|[0-9]")),
                LengthLimitingTextInputFormatter(11)
              ],
              textAlignVertical: TextAlignVertical.center,
              textInputAction: TextInputAction.next,
              style: TextStyle(fontSize: 20.0, color: Colors.black),
              //光标宽
              cursorWidth: 1.0,
              //设置输入类型，不同的输入类型键盘不一样
              keyboardType: TextInputType.text,
              obscureText: true,
              //模糊文字
              decoration: _inputDecotation("请输入密码", false),
            ),
          ),
          _text(), //用户协议
          Container(
            width: double.infinity,
            height: 50.0,
            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            child: RaisedButton(
              elevation: 0.0,
              highlightElevation: 0.0,
              highlightColor: Colors.transparent,
              //点击或者toch控件高亮的时候显示在控件上面，水波纹下面的颜色
              splashColor: Colors.transparent,
              ////水波纹的颜色
              shape: StadiumBorder(
                  side: BorderSide(
                      style: BorderStyle.solid,
                      width: 0.0,
                      color: Colors.transparent)),
              //体育场形状。即两边是半圆。
              color: bag_Color,
              onPressed: () {
                if (isLogin) {
                  _login();
                } else {
                  if (phoneController.text.length != 11 ||
                      phoneController.text[0] != "1") {
                    ToastUtils.showToast("请检查手机号是否正确！",
                        gravity: ToastGravity.CENTER);
                  } else if (passController.text.length < 6) {
                    ToastUtils.showToast("密码不能少于六位！",
                        gravity: ToastGravity.CENTER);
                  }
                }
              },
              child: Text(
                '同意协议并登录',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          )
        ],
      )),
    );
  }

/*
* 提交条件
* */
  void _login() {
    print({'phone': phoneController.text, 'password': passController.text});
    Map map = {
      "phone": phoneController.text.toString(),
      "password": passController.text.toString()
    };
    DataUtils.saveLoginInfo(map); //保存用户信息
    //成功
    Navigator.pop(context); //关闭页面
    ToastUtils.showToast("登录成功", gravity: ToastGravity.CENTER);
  }

/*
* 输入框样式
* */
  _inputDecotation(String text, bool isShow) {
    return isShow //手机号
        ? InputDecoration(
            prefixIcon: Container(
              //预先填充的Widget,跟prefixText同时只能出现一个
              width: 10,
              child: Center(
                child: Text(
                  "+86",
                  style:
                      TextStyle(fontSize: 22.0, color: ThemeUtils.text_999999),
                ),
              ),
            ),
            hintText: text,
            contentPadding: EdgeInsets.all(0.0),
            hintStyle: TextStyle(
              fontSize: 18.0,
              color: ThemeUtils.text_999999,
            ),
            //输入框样式
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ThemeUtils.text_999999, width: 0.5),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ThemeUtils.text_999999, width: 0.5),
            ),
          )
        : InputDecoration(
            //密码
            hintText: text,
            hintStyle: TextStyle(fontSize: 18.0, color: ThemeUtils.text_999999),
            //输入框样式
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ThemeUtils.text_999999, width: 0.5),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ThemeUtils.text_999999, width: 0.5),
            ),
          );
  }

/*
* 用户协议
* */
  Widget _text() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Text.rich(TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '登录注册代表同意',
            style: TextStyle(color: Colors.black, fontSize: 13.0),
          ),
          new TextSpan(
              text: '用户协议 ',
              style: TextStyle(
                  color: ThemeUtils.currentColorTheme, fontSize: 13.0),
              //增加一个点击事件
              recognizer: new TapGestureRecognizer()
                ..onTap = () =>
                    ToastUtils.showToast("用户协议", gravity: ToastGravity.CENTER)),
          new TextSpan(
            text: '和',
            style: TextStyle(color: Colors.black, fontSize: 13.0),
          ),
          new TextSpan(
              text: ' 隐私政策',
              style: TextStyle(
                  color: ThemeUtils.currentColorTheme, fontSize: 13.0),
              //增加一个点击事件
              recognizer: new TapGestureRecognizer()
                ..onTap = () =>
                    ToastUtils.showToast("隐私政策", gravity: ToastGravity.CENTER))
        ],
      )),
    );
  }
}
