part of home_screen;

class WeatherDetailScreen extends StatelessWidget {
  final String lat;
  final String long;
  final String cityName;
  const WeatherDetailScreen({
    super.key,
    required this.lat,
    required this.long,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherDataPvd(lat: lat, long: long),
        ),
      ],
      child: _MainHomeWidget(
        onLeadingIconPress: () {},
        appBarTitle: cityName,
        showAppBarIcon: false,
      ),
    );
  }
}
