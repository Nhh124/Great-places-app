import 'dart:io';

import 'package:flutter/foundation.dart';
import '/helper/db_helper.dart';
import '/helper/location.helper.dart';

import '../model/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get item {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(
    String tilte,
    File image,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.lattitude, pickedLocation.longtitude);
    final updatedLocation = PlaceLocation(
        longtitude: pickedLocation.longtitude,
        lattitude: pickedLocation.lattitude,
        address: address);
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: tilte,
      image: image,
      location: updatedLocation,
    );

    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('use_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.lattitude,
      'loc_long': newPlace.location.longtitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('use_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              address: item['address'],
              lattitude: item['loc_lat'],
              longtitude: item['loc_long'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
