import 'package:flutter/material.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/UI/image_container.dart';
import 'package:restaurant_finder/UI/retaurant_details_screen.dart';

class RestaurantTile extends StatelessWidget {
  const RestaurantTile({
    Key key,
    @required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                RestaurantDetailsScreen(restaurant: restaurant),
          ),
        );
      },
      leading: ImageContainer(width: 50, height: 50, url: restaurant.thumbUrl),
      title: Text(restaurant.name),
      trailing: Icon(Icons.keyboard_arrow_right),
    );
  }
}