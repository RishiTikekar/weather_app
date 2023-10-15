library home_screen;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/screens/search_screen/UI/search_screen.dart';
import 'package:weatherapp/screens/setting_screen/UI/setting_screen.dart';
import 'package:weatherapp/widgets/shimmers.dart';
import 'package:weatherapp/widgets/text_with_gradient.dart';
import 'package:weatherapp/screens/home_screen/provider/weather_data_pvd.dart';
import 'package:weatherapp/styles/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

part 'waether_details_screen.dart';
part './components/drawer_component.dart';
part './components/weather_detail_component.dart';
part './components/loading_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<Offset> translateAnimation;

  bool isDrawerOpened = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _DrawerScreen(
          animateDrawer: animateDrawer,
        ),
        AnimatedBuilder(
          animation: controller,
          builder: (_, child) => Transform.translate(
            offset: translateAnimation.value,
            child: Transform.scale(
              scale: scaleAnimation.value,
              child: _MainHomeWidget(
                onLeadingIconPress: animateDrawer,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    scaleAnimation = controller.drive(Tween<double>(begin: 1, end: 0.8));

    translateAnimation = controller.drive(
      Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(200, 0),
      ),
    );

    super.initState();
  }

  void animateDrawer() {
    if (isDrawerOpened) {
      controller.reverse();
    } else {
      controller.forward();
    }
    isDrawerOpened = !isDrawerOpened;
  }
}

class _LocationTile extends StatelessWidget {
  final String lat;
  final String long;
  final String cityName;
  const _LocationTile({
    required this.lat,
    required this.long,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => WeatherDetailScreen(
            lat: lat,
            long: long,
            cityName: cityName,
          ),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: const Icon(
        Icons.location_pin,
        color: Clr.white,
      ),
      dense: true,
      visualDensity: VisualDensity.compact,
      title: Text(cityName),
      titleTextStyle: TStyle.T_18_700_15(),
      style: ListTileStyle.drawer,
    );
  }
}

class _AddLocationTile extends StatelessWidget {
  const _AddLocationTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: const Icon(Icons.add_location_alt, color: Clr.CFBF99E),
      dense: true,
      visualDensity: VisualDensity.compact,
      title: const Text("Add location"),
      titleTextStyle: TStyle.T_18_700_15(Clr.CFBF99E),
      style: ListTileStyle.drawer,
    );
  }
}

class _CurrentWeatherCard extends StatelessWidget {
  const _CurrentWeatherCard();

  @override
  Widget build(BuildContext context) {
    final weatherDataPvd = context.watch<WeatherDataPvd>();
    final currentWeather = weatherDataPvd.weeklyData?['current'];
    final locationData = weatherDataPvd.weeklyData?['location'];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: Gradients.cardBlueGrad,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "${L.of(context)!.chance_of_rain} ${currentWeather['precip_in']}%",
                      style: TStyle.T_14_400_15(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${currentWeather['condition']['text']}",
                      style: TStyle.T_24_700_15(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 27),
              Image.network(
                ("https:${currentWeather['condition']['icon']}"),
                height: 77,
                width: 77,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  Assets.icCloudy,
                  height: 77,
                  width: 77,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Text.rich(
            TextSpan(
              children: [
                const WidgetSpan(
                  child: Icon(
                    Icons.location_pin,
                    size: 16,
                    color: Clr.white,
                  ),
                ),
                TextSpan(
                  text: " ${locationData['name']},${locationData['region']}",
                  style: TStyle.T_14_400_15(),
                )
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: "${currentWeather['temp_c']}",
                  style: TStyle.T_18_700_15(),
                  children: [
                    TextSpan(
                      text: ' o C',
                      style: TStyle.T_14_400_15().copyWith(
                        fontFeatures: [const FontFeature.superscripts()],
                      ),
                    )
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const WidgetSpan(
                      child: Icon(Icons.cloudy_snowing, size: 16),
                    ),
                    TextSpan(
                      text: '  ${currentWeather['precip_in']}',
                      style: TStyle.T_12_600_15(),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const WidgetSpan(
                      child: Icon(Icons.light_mode, size: 16),
                    ),
                    TextSpan(
                      text: '  ${currentWeather['uv']}',
                      style: TStyle.T_12_600_15(),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const WidgetSpan(
                      child: Icon(Icons.air, size: 16),
                    ),
                    TextSpan(
                      text: '  ${currentWeather['wind_kph']} km/h',
                      style: TStyle.T_12_600_15(),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _ForecastCard extends StatelessWidget {
  const _ForecastCard();

  @override
  Widget build(BuildContext context) {
    final weatherDataPvd = context.watch<WeatherDataPvd>();
    final forecastData = weatherDataPvd.weeklyData?['forecast']['forecastday'];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Clr.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            L.of(context)!.weekly_forecast,
            style: TStyle.T_16_600_15(Clr.C363B64),
          ),
          const SizedBox(height: 8),
          ...(forecastData as List).map(
            (forecastData) {
              return _WeeklyWeatherTile(forecastData: forecastData);
            },
          ).toList()
        ],
      ),
    );
  }
}

class _WeeklyWeatherTile extends StatelessWidget {
  final Map forecastData;
  const _WeeklyWeatherTile({
    required this.forecastData,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse("${forecastData['date']}").toLocal();
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8).copyWith(right: 5),
      visualDensity: VisualDensity.compact,
      leading: Image.network(
        'https:${forecastData['day']['condition']['icon']}',
        height: 32,
        width: 32,
        errorBuilder: (_, __, ___) =>
            Image.asset(Assets.icCloudy, height: 32, width: 32),
      ),
      title: Text(
        "${forecastData['day']['condition']['text']}",
        style: TStyle.T_14_400_15(Clr.C363B64),
      ),
      minVerticalPadding: 8,
      subtitle: Text(
        "${date.day}/${date.month}/${date.year}",
        style: TStyle.T_12_400_15(Clr.C363B64),
      ),
      trailing: Text.rich(
        TextSpan(
          text: "${forecastData['day']['avgtemp_c']}",
          style: TStyle.T_14_400_15(Clr.C363B64),
          children: [
            TextSpan(
              text: " o C",
              style: TStyle.T_14_400_15(Clr.C363B64).copyWith(
                fontFeatures: const [FontFeature.superscripts()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationPermissionWidget extends StatelessWidget {
  const _LocationPermissionWidget();

  @override
  Widget build(BuildContext context) {
    final weatherDataPvd = context.read<WeatherDataPvd>();
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height - 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wrong_location,
            color: Clr.blue,
            size: 45,
          ),
          const SizedBox(height: 16),
          Text(
            L.of(context)!.permission_subtitle,
            style: TStyle.T_16_400_15(Clr.C363B64),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => weatherDataPvd.retryLocationPermission(),
            child: Text(L.of(context)!.give_permission),
          )
        ],
      ),
    );
  }
}
