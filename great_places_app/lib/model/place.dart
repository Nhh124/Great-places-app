// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class PlaceLocation {
  final double longtitude;
  final double lattitude;
  final String address;
  const PlaceLocation({
    required this.longtitude,
    required this.lattitude,
    required this.address,
  });
}

class Place {
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;
  Place({
    required this.id,
    required this.title,
    required this.image,
    required this.location,
  });
}
