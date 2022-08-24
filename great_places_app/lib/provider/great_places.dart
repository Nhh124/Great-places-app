import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places_app/helper/db_helper.dart';

import '../model/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get item {
    return [..._items];
  }

  void addPlace(String tilte, File image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: tilte,
      image: image,
      location: PlaceLocation(
        address: "",
        lattitude: 0.0,
        longtitude: 0.0,
      ),
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('use_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
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
              address: "",
              lattitude: 0.0,
              longtitude: 0.0,
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
