import 'package:my_client_app/generated/json/base/json_convert_content.dart';

class ForecastEntity with JsonConvert<ForecastEntity> {
	ForecastData data;
	int status;
	String desc;
}

class ForecastData with JsonConvert<ForecastData> {
	ForecastDataYesterday yesterday;
	String city;
	List<ForecastDataForecast> forecast;
	String ganmao;
	String wendu;
}

class ForecastDataYesterday with JsonConvert<ForecastDataYesterday> {
	String date;
	String high;
	String fx;
	String low;
	String fl;
	String type;
}

class ForecastDataForecast with JsonConvert<ForecastDataForecast> {
	String date;
	String high;
	String fengli;
	String low;
	String fengxiang;
	String type;
}
