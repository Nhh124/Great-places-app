import 'dart:io';

import 'package:flutter/material.dart';
import '/model/place.dart';
import '/provider/great_places.dart';
import '/widgets/location_input.dart';
import 'package:provider/provider.dart';
import '/widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);
  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickerlocation;
  void _selectImage(File? pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double long) {
    _pickerlocation =
        PlaceLocation(address: '', lattitude: lat, longtitude: long);
  }

  void _savedPlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickerlocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!, _pickerlocation!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        label: Text('Title'),
                      ),
                      controller: _titleController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ImageInput(onselectedImage: _selectImage),
                    const SizedBox(
                      height: 10,
                    ),
                    LocationInput(onselectPlace: _selectPlace),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savedPlace,
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            label: const Text(
              'Add Place',
              style: TextStyle(color: Colors.black),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              primary: Colors.amberAccent,
            ),
          ),
        ],
      ),
    );
  }
}
