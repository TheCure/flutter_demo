import 'package:flutter/material.dart';

class ThemeUtils {
  // 默认主题色
  static const Color defaultColor = const Color(0xFF63CA6C);
  static const Color text_999999 = const Color(0xFF999999);
  static const Color text_333333 = const Color(0xFF333333);
  static const Color text_cccccc = const Color(0xFFcccccc);
  static const Color text_f9f9f9 = const Color(0xFFf9f9f9);

  // 可选的主题色
  static const List<Color> supportColors = [
    defaultColor,
    Colors.purple,
    Colors.orange,
    Colors.deepPurpleAccent,
    Colors.redAccent,
    Colors.blue,
    Colors.amber,
    Colors.green,
    Colors.lime,
    Colors.indigo,
    Colors.cyan,
    Colors.teal
  ];

  // 当前的主题色
  static Color currentColorTheme = defaultColor;
}