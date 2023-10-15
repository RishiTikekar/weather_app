import 'package:get_it/get_it.dart';
import 'package:weatherapp/screens/setting_screen/provider/locale_pvd.dart';
import 'package:weatherapp/utils/api_util.dart';

export 'package:weatherapp/utils/api_util.dart';
export 'package:get_it/get_it.dart';
export 'package:weatherapp/screens/setting_screen/provider/locale_pvd.dart';

GetIt getIt = GetIt.instance;

void initServices() {
  getIt.registerLazySingleton(() => ApiUtil());

  getIt.registerLazySingleton(() => LocalePvd());
}
