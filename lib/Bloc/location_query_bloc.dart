import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_finder/Bloc/BaseModel.dart';
import 'package:restaurant_finder/DataLayer/location.dart';
import 'package:restaurant_finder/DataLayer/zomato_client.dart';

class LocationQueryNotifier extends BaseViewModel {
  List<Location> _locations;
  List<Location> get locations => _locations;
  final _client = ZomatoClient();

  Future<void> submitQuery(String query) async {
    setState(ViewState.busy);
    print(query);
    if (query.isEmpty) {
      _locations.clear();
      setState(ViewState.idle);
      return;
    }
    final results = await _client.fetchLocations(query);
    _locations = results.toList();
    if (results.isNotEmpty) {
      setState(ViewState.dataAvailable);
    }
  }
}
