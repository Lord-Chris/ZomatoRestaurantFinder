import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_finder/Bloc/BaseModel.dart';
import 'package:restaurant_finder/DataLayer/location.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/DataLayer/zomato_client.dart';

class RestaurantNotifier extends BaseViewModel {
  final _client = ZomatoClient();

  List<Restaurant> _restaurants;
  List<Restaurant> get restaurants => _restaurants;

  Future<void> submitQuery(String query, Location location) async {
    if (query.isEmpty) {
      setState(ViewState.idle);
      return;
    }
    
    setState(ViewState.busy);
    final results = await _client.fetchRestaurants(location, query);
    _restaurants = results.toList();
    if (results.isNotEmpty) {
      setState(ViewState.dataAvailable);
    }
  }
}
