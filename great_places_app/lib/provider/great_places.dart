import 'package:flutter/foundation.dart';

import '../model/place.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get item {
    return [..._items];
  }
}
