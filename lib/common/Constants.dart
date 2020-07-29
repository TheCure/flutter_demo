import 'package:event_bus/event_bus.dart';

class Constants {
  //"http://wthrcdn.etouch.cn/weather_mini"
  static const String BASE_URL = "http://wthrcdn.etouch.cn/";
  static const String JISUJOKE = "weather_mini";


  static final EventBus eventBus = new EventBus();
}
