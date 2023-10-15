part of home_screen;

class _DrawerScreen extends StatelessWidget {
  final Function() animateDrawer;
  _DrawerScreen({
    required this.animateDrawer,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(gradient: Gradients.blueGrad),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 56),
            SizedBox(
              height: 56,
              child: Row(
                children: [
                  IconButton(
                    onPressed: animateDrawer,
                    icon: const Icon(Icons.menu),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    color: Clr.white,
                  ),
                  TextWithGradient(
                    text: L.of(context)!.location,
                    style: TStyle.T_14_400_15(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ...favCities
                .map(
                  (cityDetails) => _LocationTile(
                    lat: cityDetails['lat'],
                    long: cityDetails['long'],
                    cityName: cityDetails['cityName'],
                  ),
                )
                .toList(),
            const SizedBox(height: 100),
            const Spacer(flex: 3),
            TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingScreen()),
              ),
              child: Text(L.of(context)!.settings),
            ),
            TextButton(
              onPressed: () {},
              child: Text(L.of(context)!.share_this_app),
            ),
            TextButton(
              onPressed: () {},
              child: Text(L.of(context)!.rate_this_app),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  final List<Map> favCities = [
    {'lat': '43.6532', 'long': '79.3832', 'cityName': 'Toronto'},
    {'lat': '36.1716', 'long': '115.1391', 'cityName': 'Las Vegas'},
    {'lat': '19.0760', 'long': '72.8777', 'cityName': 'Mumbai'},
    {'lat': '35.6764', 'long': '139.6500', 'cityName': 'Tokyo'},
  ];
}
