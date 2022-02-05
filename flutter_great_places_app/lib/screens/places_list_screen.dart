import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/place_detals_screen.dart';
import 'package:provider/provider.dart';
import '../screens/add_places_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatePlaces>(context, listen: false)
            .fetchAndSetPlace(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatePlaces>(
                child: Center(
                  child: Text('Got no places yet sart adding some'),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (ctx, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatPlaces.items[index].image),
                          ),
                          title: Text(greatPlaces.items[index].title),
                          subtitle:
                              Text(greatPlaces.items[index].location.address),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                ProductDetailScreen.routeName,
                                arguments: "${greatPlaces.items[index].id}");
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
