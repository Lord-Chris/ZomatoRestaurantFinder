import 'package:flutter/material.dart';
import 'package:restaurant_finder/Bloc/BaseModel.dart';
import 'package:restaurant_finder/Bloc/location_bloc.dart';
import 'package:restaurant_finder/Bloc/location_query_bloc.dart';
import 'package:restaurant_finder/Bloc/restaurant_bloc.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/UI/favourite_screen.dart';
import 'package:restaurant_finder/UI/location_screen.dart';
import 'package:restaurant_finder/UI/restauran_tile.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class RestaurantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RestaurantNotifier>.nonReactive(
      viewModelBuilder: () => RestaurantNotifier(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          title: AppBarText(),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => FavoriteScreen())),
            )
          ],
        ),
        body: BuildSearchResults(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit_location),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LocationScreen(
                    isFullScreenDialog: true,
                  ),
              fullscreenDialog: true)),
        ),
      ),
    );
  }
}

class BuildSearchResults extends ViewModelWidget<RestaurantNotifier> {
  @override
  Widget build(BuildContext context, RestaurantNotifier viewModel) {
    final bloc2 = Provider.of<LocationNotifier>(context, listen: false);

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'What do you want to eat?'),
            onChanged: (query) =>
                viewModel.submitQuery(query, bloc2.selectedLocation),
          ),
        ),
        Expanded(
          child: Results(),
        )
      ],
    );
  }
}

class Results extends ViewModelWidget<RestaurantNotifier> {
  Widget _buildSearchResults(List<Restaurant> results) {
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final restaurant = results[index];
        return RestaurantTile(restaurant: restaurant);
      },
    );
  }

  @override
  Widget build(BuildContext context, RestaurantNotifier viewModel) {
    switch (viewModel.state) {
      case ViewState.idle:
        return Center(child: Text('Enter a restaurant name or cuisine type'));
        break;
      case ViewState.noData:
        return Center(child: Text('No results'));
      case ViewState.dataAvailable:
        return _buildSearchResults(viewModel.restaurants);

      case ViewState.busy:
        return Center(child: CircularProgressIndicator());

      default:
        return Center(child: Text('Enter a location'));
    }
  }
}

class AppBarText extends ViewModelWidget<LocationNotifier> {
  @override
  Widget build(BuildContext context, LocationNotifier model) {
    return Text(model.selectedLocation.title);
  }
}
