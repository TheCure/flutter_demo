import 'package:json_annotation/json_annotation.dart';

part 'user_bean.g.dart';


@JsonSerializable()
class UserBean extends Object {

  @JsonKey(name: 'data')
  Data data;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'desc')
  String desc;

  UserBean(this.data,this.status,this.desc,);

  factory UserBean.fromJson(Map<String, dynamic> srcJson) => _$UserBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserBeanToJson(this);

}


@JsonSerializable()
class Data extends Object {

  @JsonKey(name: 'yesterday')
  Yesterday yesterday;

  @JsonKey(name: 'city')
  String city;

  @JsonKey(name: 'forecast')
  List<Forecast> forecast;

  @JsonKey(name: 'ganmao')
  String ganmao;

  @JsonKey(name: 'wendu')
  String wendu;

  Data(this.yesterday,this.city,this.forecast,this.ganmao,this.wendu,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}


@JsonSerializable()
class Yesterday extends Object {

  @JsonKey(name: 'date')
  String date;

  @JsonKey(name: 'high')
  String high;

  @JsonKey(name: 'fx')
  String fx;

  @JsonKey(name: 'low')
  String low;

  @JsonKey(name: 'fl')
  String fl;

  @JsonKey(name: 'type')
  String type;

  Yesterday(this.date,this.high,this.fx,this.low,this.fl,this.type,);

  factory Yesterday.fromJson(Map<String, dynamic> srcJson) => _$YesterdayFromJson(srcJson);

  Map<String, dynamic> toJson() => _$YesterdayToJson(this);

}


@JsonSerializable()
class Forecast extends Object {

  @JsonKey(name: 'date')
  String date;

  @JsonKey(name: 'high')
  String high;

  @JsonKey(name: 'fengli')
  String fengli;

  @JsonKey(name: 'low')
  String low;

  @JsonKey(name: 'fengxiang')
  String fengxiang;

  @JsonKey(name: 'type')
  String type;

  Forecast(this.date,this.high,this.fengli,this.low,this.fengxiang,this.type,);

  factory Forecast.fromJson(Map<String, dynamic> srcJson) => _$ForecastFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ForecastToJson(this);

}


