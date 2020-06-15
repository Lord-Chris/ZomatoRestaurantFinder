import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_finder/Bloc/BaseModel.dart';
import 'package:restaurant_finder/Bloc/location_bloc.dart';
import 'package:restaurant_finder/Bloc/location_query_bloc.dart';
import 'package:restaurant_finder/UI/restaurant_screen.dart';
import 'package:stacked/stacked.dart';

class LocationScreen extends StatelessWidget {
  final bool isFullScreenDialog;
  const LocationScreen({Key key, this.isFullScreenDialog = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LocationQueryNotifier>.nonReactive(
      viewModelBuilder: () => LocationQueryNotifier(),
      builder: (context, model, _) => Scaffold(
          appBar: AppBar(title: Text('Where do you want to eat?')),
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a location'),
                  onChanged: (query) {
                    model.submitQuery(query);
                  },
                ),
              ),
              Expanded(
                child: Results(isFullScreenDialog),
              )
            ],
          )),
    );
  }
}

class Results extends ViewModelWidget<LocationQueryNotifier> {
  final bool isFullScreenDialog;

  Results(this.isFullScreenDialog);

  Widget _buildSearchResults(LocationQueryNotifier value) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: value.locations.length,
      itemBuilder: (context, index) {
        final location = value.locations[index];
        return ListTile(
          title: Text(location.title),
          onTap: () {
            final model = Provider.of<LocationNotifier>(context, listen: false);
            model.selectLocation(location);

            if (isFullScreenDialog) {
              Navigator.of(context).pop();
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RestaurantScreen()));
            }
          },
        );
      },
    );
  }

 

  @override
  Widget build(BuildContext context, LocationQueryNotifier viewModel) {
    switch (viewModel.state) {
      case ViewState.idle:
        return Center(child: Text('Enter a location'));
        break;
      case ViewState.noData:
        return Center(child: Text('No results'));
      case ViewState.dataAvailable:
        return _buildSearchResults(viewModel);

      case ViewState.busy:
        return Center(child: CircularProgressIndicator());

      default:
        return Center(child: Text('Enter a location'));
    }
  }
}
