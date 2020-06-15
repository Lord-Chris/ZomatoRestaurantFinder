import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_finder/Bloc/BaseModel.dart';
import 'package:restaurant_finder/Bloc/favorite_bloc.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/UI/restauran_tile.dart';
import 'package:stacked/stacked.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
        ),
        body: Favourites());
  }
}

class Favourites extends ViewModelWidget<FavouriteNotifier> {
  @override
  Widget build(BuildContext context, FavouriteNotifier model) {
    switch (model.state) {
      case ViewState.idle:
        return Center(child: Text('No favourites'));
        break;
      case ViewState.noData:
        return Center(child: Text('No results'));
      case ViewState.dataAvailable:
        return Container(
          margin: EdgeInsets.only(top:10),
          child: ListView.separated(
            itemCount: model.favourites.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final restaurant = model.favourites[index];
              return RestaurantTile(restaurant: restaurant);
            },
          ),
        );

      case ViewState.busy:
        return Center(child: CircularProgressIndicator());

      default:
        return Center(child: Text('Enter a location'));
    }
  }
}
