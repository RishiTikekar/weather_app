import 'package:flutter/material.dart';
import 'package:weatherapp/global_providers/helper_mixin/continuouse_search.dart';
import 'package:weatherapp/global_providers/helper_mixin/loading_util.dart';
import 'package:weatherapp/global_providers/helper_mixin/validator_mixin.dart';
import 'package:weatherapp/screens/search_screen/repo/location_repo.dart';
import 'package:weatherapp/utils/util_fun.dart';

enum LocationType {
  cityName('search city'),
  latLong('search lat-long');

  final String displayName;
  const LocationType(this.displayName);
}

class LocationDataPvd
    with ChangeNotifier, ValidatorsMixin, ContinuousSearch, LoadingUtil {
  LocationDataPvd() {
    listenTextCtrl();
  }

  LocationType locationType = LocationType.cityName;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List searchResult = [];

  selectLocationType(LocationType? type) {
    if (type != null) {
      locationType = type;
      notifyListeners();
    }
  }

  final LocationRepo _repo = LocationRepo();

  TextEditingController latCtrl = TextEditingController();
  TextEditingController longCtrl = TextEditingController();

  void searchByLatLong(Function() onValid) {
    if (formKey.currentState?.validate() ?? false) {
      onValid.call();
    }
  }

  @override
  void dispose() {
    latCtrl.dispose();
    longCtrl.dispose();
    super.dispose();
  }

  @override
  onSearch(String searchData) async {
    try {
      isLoading = true;

      List? result = await _repo.getLatLongFromCity(searchData);
      if (UtilFun.isValidList(result)) {
        searchResult = result!;
      }
    } finally {
      isLoading = false;
    }
  }

  @override
  bool get hasData => UtilFun.isValidList(searchResult);
}
