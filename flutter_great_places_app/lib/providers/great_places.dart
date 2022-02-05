import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

import '../models/places.dart';
import '../helpers/db_helper.dart';
import '../helpers/locatioon_helper.dart';

class GreatePlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void addPlace(
      String pickedTitle, File pickedImage, PlaceLocation location) async {
    final address = await LocationHelper.getPlaceAddress(
        location.latitude, location.longitude);
    PlaceLocation updatedLocation = PlaceLocation(
        latitude: location.latitude,
        longitude: location.longitude,
        address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: pickedTitle,
        image: pickedImage,
        location: updatedLocation);

    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'loc_lat': newPlace.location.latitude,
        'loc_long': newPlace.location.longitude,
        'address': newPlace.location.address
      },
    );
  }

  Future<void> fetchAndSetPlace() async {
    final dataList = await DBHelper.getAllData('user_places');
    _items = dataList
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
                latitude: item['loc_lat'],
                longitude: item['loc_long'],
                address: item['address'])))
        .toList();
    notifyListeners();
  }
}
