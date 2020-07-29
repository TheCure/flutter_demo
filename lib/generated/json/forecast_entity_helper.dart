import 'package:my_client_app/models/forecast_entity.dart';

forecastEntityFromJson(ForecastEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new ForecastData().fromJson(json['data']);
	}
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	if (json['desc'] != null) {
		data.desc = json['desc']?.toString();
	}
	return data;
}

Map<String, dynamic> forecastEntityToJson(ForecastEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['status'] = entity.status;
	data['desc'] = entity.desc;
	return data;
}

forecastDataFromJson(ForecastData data, Map<String, dynamic> json) {
	if (json['yesterday'] != null) {
		data.yesterday = new ForecastDataYesterday().fromJson(json['yesterday']);
	}
	if (json['city'] != null) {
		data.city = json['city']?.toString();
	}
	if (json['forecast'] != null) {
		data.forecast = new List<ForecastDataForecast>();
		(json['forecast'] as List).forEach((v) {
			data.forecast.add(new ForecastDataForecast().fromJson(v));
		});
	}
	if (json['ganmao'] != null) {
		data.ganmao = json['ganmao']?.toString();
	}
	if (json['wendu'] != null) {
		data.wendu = json['wendu']?.toString();
	}
	return data;
}

Map<String, dynamic> forecastDataToJson(ForecastData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.yesterday != null) {
		data['yesterday'] = entity.yesterday.toJson();
	}
	data['city'] = entity.city;
	if (entity.forecast != null) {
		data['forecast'] =  entity.forecast.map((v) => v.toJson()).toList();
	}
	data['ganmao'] = entity.ganmao;
	data['wendu'] = entity.wendu;
	return data;
}

forecastDataYesterdayFromJson(ForecastDataYesterday data, Map<String, dynamic> json) {
	if (json['date'] != null) {
		data.date = json['date']?.toString();
	}
	if (json['high'] != null) {
		data.high = json['high']?.toString();
	}
	if (json['fx'] != null) {
		data.fx = json['fx']?.toString();
	}
	if (json['low'] != null) {
		data.low = json['low']?.toString();
	}
	if (json['fl'] != null) {
		data.fl = json['fl']?.toString();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toString();
	}
	return data;
}

Map<String, dynamic> forecastDataYesterdayToJson(ForecastDataYesterday entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['date'] = entity.date;
	data['high'] = entity.high;
	data['fx'] = entity.fx;
	data['low'] = entity.low;
	data['fl'] = entity.fl;
	data['type'] = entity.type;
	return data;
}

forecastDataForecastFromJson(ForecastDataForecast data, Map<String, dynamic> json) {
	if (json['date'] != null) {
		data.date = json['date']?.toString();
	}
	if (json['high'] != null) {
		data.high = json['high']?.toString();
	}
	if (json['fengli'] != null) {
		data.fengli = json['fengli']?.toString();
	}
	if (json['low'] != null) {
		data.low = json['low']?.toString();
	}
	if (json['fengxiang'] != null) {
		data.fengxiang = json['fengxiang']?.toString();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toString();
	}
	return data;
}

Map<String, dynamic> forecastDataForecastToJson(ForecastDataForecast entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['date'] = entity.date;
	data['high'] = entity.high;
	data['fengli'] = entity.fengli;
	data['low'] = entity.low;
	data['fengxiang'] = entity.fengxiang;
	data['type'] = entity.type;
	return data;
}