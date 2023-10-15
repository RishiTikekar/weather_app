import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/screens/home_screen/UI/home_screen.dart';
import 'package:weatherapp/widgets/shimmers.dart';
import 'package:weatherapp/screens/search_screen/provider/location_data_pvd.dart';
import 'package:weatherapp/styles/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationDataPvd()),
      ],
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final locationPvd = context.watch<LocationDataPvd>();
    return SafeArea(
      bottom: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).hasFocus
            ? FocusScope.of(context).unfocus()
            : null,
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_ios_new, color: Clr.C363B64),
              ),
              title: Text(L.of(context)!.search_weather),
            ),
            body: Form(
              key: locationPvd.formKey,
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.all(16),
                children: [
                  Card(
                    color: Clr.white,
                    child: DefaultTextStyle(
                      style: TStyle.T_16_400_15(Clr.C363B64),
                      child: DropdownButton<LocationType>(
                        dropdownColor: Clr.white,
                        padding: const EdgeInsets.all(8).copyWith(left: 20),
                        underline: const SizedBox(),
                        style: TStyle.T_16_400_15(Clr.C363B64),
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(
                            value: LocationType.cityName,
                            child: Text(LocationType.cityName.displayName),
                          ),
                          DropdownMenuItem(
                            value: LocationType.latLong,
                            child: Text(LocationType.latLong.displayName),
                          ),
                        ],
                        hint: Text(locationPvd.locationType.displayName),
                        onChanged: locationPvd.selectLocationType,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (locationPvd.locationType == LocationType.latLong) ...[
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: locationPvd.latCtrl,
                            style: TStyle.T_16_400_15(Clr.C363B64),
                            decoration: InputDecoration(
                              hintText: L.of(context)!.latitude,
                            ),
                            keyboardType: TextInputType.number,
                            validator: locationPvd.emptyFieldValidation,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: TextFormField(
                            controller: locationPvd.longCtrl,
                            style: TStyle.T_16_400_15(Clr.C363B64),
                            decoration: InputDecoration(
                              hintText: L.of(context)!.longitude,
                            ),
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: locationPvd.emptyFieldValidation,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => locationPvd.searchByLatLong(
                        () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WeatherDetailScreen(
                              lat: locationPvd.latCtrl.text,
                              long: locationPvd.longCtrl.text,
                              cityName: "",
                            ),
                          ),
                        ),
                      ),
                      child: Text(L.of(context)!.search),
                    ),
                  ] else ...[
                    TextFormField(
                      style: TStyle.T_16_400_15(Clr.C363B64),
                      decoration: InputDecoration(
                        hintText: L.of(context)!.search_city_name,
                      ),
                      validator: locationPvd.emptyFieldValidation,
                      controller: locationPvd.searchCtrl,
                    ),
                    const SizedBox(height: 16),
                    if (locationPvd.isLoading)
                      const _LoadingState()
                    else if (locationPvd.hasData) ...[
                      const _LocationList(),
                    ] else
                      const _EmptyState(),
                  ],
                ],
              ),
            )),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.filled(
          5,
          const Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: BoxShimmer(
                          height: 24,
                          width: double.infinity,
                          theme: ColorTheme.grey,
                        ),
                      ),
                      SizedBox(width: 20),
                      BoxShimmer(height: 36, width: 70, theme: ColorTheme.grey),
                    ],
                  ),
                  SizedBox(height: 20),
                  BoxShimmer(height: 18, width: 230, theme: ColorTheme.grey),
                ],
              ),
            ),
          )),
    );
  }
}

class _LocationList extends StatelessWidget {
  const _LocationList();

  @override
  Widget build(BuildContext context) {
    final locationPvd = context.watch<LocationDataPvd>();
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: locationPvd.searchResult
          .map(
            (result) => Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => WeatherDetailScreen(
                      lat: "${result['lat']}",
                      long: "${result['lon']}",
                      cityName: "${result['name']}",
                    ),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              result['name'],
                              style: TStyle.T_16_400_15(Clr.C363B64),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            "Lat: ${result['lat']}\n Long: ${result['lon']} ",
                            style: TStyle.T_12_400_15(Clr.C363B64),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "${result['region']}, ${result['country']}",
                        style: TStyle.T_12_400_15(Clr.C363B64),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.mood_bad_outlined,
              color: Clr.C363B64,
              size: 55,
            ),
            const SizedBox(height: 10),
            Text(
              L.of(context)!.empty_state_title,
              style: TStyle.T_16_400_15(Clr.C363B64),
            )
          ],
        ),
      ),
    );
  }
}
