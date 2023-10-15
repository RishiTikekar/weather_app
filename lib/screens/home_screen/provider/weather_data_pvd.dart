import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart'
    show openAppSettings;
import 'package:weatherapp/global_providers/helper_mixin/loading_util.dart';
import 'package:weatherapp/screens/home_screen/repo/weather_repo.dart';
import 'package:weatherapp/utils/app_config.dart';
import 'package:weatherapp/utils/util_fun.dart';
import 'package:location/location.dart';

class WeatherDataPvd with ChangeNotifier, LoadingUtil {
  String? lat;
  String? long;

  Map? weeklyData;

  final WeatherRepo _repo = WeatherRepo();
  Location location = Location();

  bool hasPermission = false;

  WeatherDataPvd({this.lat, this.long}) {
    init();
  }

  Future<void> retryLocationPermission() async {
    bool isOpened = await openAppSettings();
    if (isOpened) {
      await init();
    }
  }

  Future<void> getLocationPermission() async {
    PermissionStatus status = await location.requestPermission();
    if ([PermissionStatus.granted, PermissionStatus.grantedLimited]
        .contains(status)) {
      hasPermission = true;

      LocationData locationData = await location.getLocation();
      lat = '${locationData.latitude}';
      long = '${locationData.longitude}';
    } else {
      hasPermission = false;
    }
  }

  Future<void> init() async {
    try {
      isLoading = true;
      if (!UtilFun.isValidString(lat)) {
        await getLocationPermission();
      } else {
        hasPermission = true;
      }

      await getWeatherDetails();
    } finally {
      isLoading = false;
    }
  }

  Future<void> getWeatherDetails() async {
    if (lat == null || long == null) return;
    weeklyData = await _repo.get5DayForecast(lat: lat, long: long);
  }

  String? getWeatherIcon(String subUrl) => "${AppConfig.base_url}$subUrl";

  @override
  bool get hasData => UtilFun.isValidMap(weeklyData);
}
