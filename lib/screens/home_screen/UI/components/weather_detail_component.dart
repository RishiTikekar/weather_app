part of home_screen;

class _MainHomeWidget extends StatelessWidget {
  final void Function() onLeadingIconPress;
  final String? appBarTitle;
  final bool showAppBarIcon;
  const _MainHomeWidget({
    required this.onLeadingIconPress,
    // ignore: unused_element
    this.appBarTitle,
    // ignore: unused_element
    this.showAppBarIcon = true,
  });
  @override
  Widget build(BuildContext context) {
    final weatherDataPvd = context.watch<WeatherDataPvd>();
    return Scaffold(
      backgroundColor: Clr.CD3D3D3,
      body: Scaffold(
        backgroundColor: Clr.white80,
        appBar: AppBar(
          leading: showAppBarIcon
              ? IconButton(
                  onPressed: onLeadingIconPress,
                  icon: const Icon(Icons.menu),
                  color: Clr.C363B64,
                )
              : null,
          title: Text(appBarTitle ?? L.of(context)!.your_location),
          actions: showAppBarIcon
              ? [
                  IconButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const SearchScreen(),
                      ),
                    ),
                    color: Clr.C363B64,
                    icon: const Icon(Icons.search),
                  ),
                ]
              : null,
        ),
        body: RefreshIndicator(
          onRefresh: weatherDataPvd.init,
          child: ListView(
            padding: const EdgeInsets.all(16),
            // child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (weatherDataPvd.isLoading) ...[
                const _WeatherCardShimmer(),
              ] else ...[
                if (!weatherDataPvd.hasPermission)
                  const _LocationPermissionWidget()
                else if (weatherDataPvd.hasData) ...[
                  const _CurrentWeatherCard(),
                  const SizedBox(height: 16),
                  Text(
                    L.of(context)!.forecast,
                    style: TStyle.T_16_400_15(Clr.C363B64),
                  ),
                  const SizedBox(height: 16),
                  const _ForecastCard(),
                ] else ...[
                  const _ErrorState(),
                ]
              ]
            ],
            // ),
          ),
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState();

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
            Icons.error,
            color: Clr.blue,
            size: 45,
          ),
          const SizedBox(height: 16),
          Text(
            L.of(context)!.error_text,
            style: TStyle.T_16_400_15(Clr.C363B64),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => weatherDataPvd.init(),
            child: Text(L.of(context)!.retry),
          )
        ],
      ),
    );
  }
}
