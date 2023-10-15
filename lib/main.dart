import 'package:flutter/material.dart';
import 'package:weatherapp/screens/home_screen/UI/home_screen.dart';
import 'package:weatherapp/widgets/app_overlay_widgets.dart';
import 'package:weatherapp/global_providers/connectivity_pvd.dart';
import 'package:weatherapp/screens/home_screen/provider/weather_data_pvd.dart';
import 'package:weatherapp/styles/styles.dart';
import 'package:weatherapp/utils/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConnectivityPvd()),
        ChangeNotifierProvider(create: (_) => WeatherDataPvd()),
        ChangeNotifierProvider(create: (_) => getIt<LocalePvd>()),
      ],
      child: Consumer<LocalePvd>(
        builder: (context, localePvd, _) => MaterialApp(
          navigatorKey: localePvd.navigationKey,
          localizationsDelegates: const [
            L.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale(LocalType.english.locale),
            Locale(LocalType.marathi.locale),
          ],
          locale: Locale(localePvd.selectedLocale.locale),
          title: 'Flutter Demo',
          theme: AppTheme.themeData,
          home: const OverlayWidget(
            child: HomeScreen(),
          ),
        ),
      ),
    );
  }
}
