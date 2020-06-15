import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_finder/Bloc/BaseModel.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';

class FavouriteNotifier extends BaseViewModel {
  var _restaurants = <Restaurant>[];
  List<Restaurant> get favourites => _restaurants;

  void toggleResataurant(Restaurant restaurant) {
    if (_restaurants.contains(restaurant)) {
      _restaurants.remove(restaurant);
    } else {
      _restaurants.add(restaurant);
    }

    setState(ViewState.dataAvailable);

    notifyListeners();
  }
}
