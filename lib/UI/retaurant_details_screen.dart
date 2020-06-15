import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_finder/Bloc/favorite_bloc.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/UI/image_container.dart';
import 'package:stacked/stacked.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailsScreen({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(restaurant.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildBanner(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  restaurant.cuisines,
                  style: textTheme.subtitle.copyWith(fontSize: 18),
                ),
                Text(
                  restaurant.address,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                ),
              ],
            ),
          ),
          _buildDetails(context),
          FavouritButton(restaurant),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return ImageContainer(
      height: 200,
      url: restaurant.imageUrl,
    );
  }

  Widget _buildDetails(BuildContext context) {
    final style = TextStyle(fontSize: 16);

    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Price: ${restaurant.priceDisplay}',
            style: style,
          ),
          SizedBox(width: 40),
          Text(
            'Rating: ${restaurant.rating.average}',
            style: style,
          ),
        ],
      ),
    );
  }
}

class FavouritButton extends ViewModelWidget<FavouriteNotifier> {
  final Restaurant restaurant;

  FavouritButton(this.restaurant);
  @override
  Widget build(BuildContext context, FavouriteNotifier value) {
    bool isFavorite = value.favourites.contains(restaurant);

    return FlatButton.icon(
      // 2
      onPressed: () => value.toggleResataurant(restaurant),
      textColor: isFavorite ? Theme.of(context).accentColor : null,
      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
      label: Text('Favorite'),
    );
  }
}
