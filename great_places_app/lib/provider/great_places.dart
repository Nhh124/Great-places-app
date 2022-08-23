import 'dart:io';

import 'package:flutter/foundation.dart';

import '../model/place.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];

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
  }
}
