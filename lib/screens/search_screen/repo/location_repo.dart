import 'package:weatherapp/utils/service_locator.dart';

///Repo to handle location search related call
class LocationRepo {
  final ApiUtil _util = getIt<ApiUtil>();

  Future<List?> getLatLongFromCity(String cityName) async {
    return (await _util.get(
      'search.json',
      queryParam: {
        'q': cityName,
        'lang': getIt<LocalePvd>().selectedLocale.locale,
      },
    ));
  }
}
