// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBean _$UserBeanFromJson(Map<String, dynamic> json) {
  return UserBean(
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
    json['status'] as int,
    json['desc'] as String,
  );
}

Map<String, dynamic> _$UserBeanToJson(UserBean instance) => <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'desc': instance.desc,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['yesterday'] == null
        ? null
        : Yesterday.fromJson(json['yesterday'] as Map<String, dynamic>),
    json['city'] as String,
    (json['forecast'] as List)
        ?.map((e) =>
            e == null ? null : Forecast.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['ganmao'] as String,
    json['wendu'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'yesterday': instance.yesterday,
      'city': instance.city,
      'forecast': instance.forecast,
      'ganmao': instance.ganmao,
      'wendu': instance.wendu,
    };

Yesterday _$YesterdayFromJson(Map<String, dynamic> json) {
  return Yesterday(
    json['date'] as String,
    json['high'] as String,
    json['fx'] as String,
    json['low'] as String,
    json['fl'] as String,
    json['type'] as String,
  );
}

Map<String, dynamic> _$YesterdayToJson(Yesterday instance) => <String, dynamic>{
      'date': instance.date,
      'high': instance.high,
      'fx': instance.fx,
      'low': instance.low,
      'fl': instance.fl,
      'type': instance.type,
    };

Forecast _$ForecastFromJson(Map<String, dynamic> json) {
  return Forecast(
    json['date'] as String,
    json['high'] as String,
    json['fengli'] as String,
    json['low'] as String,
    json['fengxiang'] as String,
    json['type'] as String,
  );
}

Map<String, dynamic> _$ForecastToJson(Forecast instance) => <String, dynamic>{
      'date': instance.date,
      'high': instance.high,
      'fengli': instance.fengli,
      'low': instance.low,
      'fengxiang': instance.fengxiang,
      'type': instance.type,
    };
