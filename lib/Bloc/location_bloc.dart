import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_finder/Bloc/BaseModel.dart';
import 'package:restaurant_finder/DataLayer/location.dart';

class LocationNotifier extends BaseViewModel {
  Location _location;
  Location get selectedLocation => _location;

  void selectLocation(Location location) {
    _location = location;
    notifyListeners();
  }
}
