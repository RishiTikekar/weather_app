import 'package:weatherapp/utils/service_locator.dart';

///Repo to handle weather related call
class WeatherRepo {
  final ApiUtil _util = getIt<ApiUtil>();

  Future<Map?> get5DayForecast({
    required String? lat,
    required String? long,
  }) async {
    return await _util.get(
      'forecast.json',
      queryParam: {
        'query': "$lat,$long",
        'days': 5,
        'aqi': 'no',
        'alerts': 'no',
        'lang': getIt<LocalePvd>().selectedLocale.locale,
        'hour': 'no',
        'astro': 'no',
        'tp': 24,
      },
    );
  }
}
