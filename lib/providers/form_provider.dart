import 'dart:io';

import 'package:favorite_places/providers/fav_places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/models/place.dart';

class FormNotifier extends ChangeNotifier {
  FormNotifier(this.ref) : super();

  Ref ref;

  PlaceLocation? _pickedLocation;
  File? _selectedImage;
  String _title = ""; // form title field
  final _formKey = GlobalKey<FormState>(); // form key

  GlobalKey<FormState> get formKey => _formKey;

  String get title => _title; // form title getter

  File? get selectedImage => _selectedImage; // getter for image

  PlaceLocation? get pickedLocation => _pickedLocation;

  void setLocation(PlaceLocation location) {
    _pickedLocation = location;
    notifyListeners();
  }

  void setImage(File image) {
    _selectedImage = image;
    notifyListeners();
  }

  // form title setter
  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  // used in form to save a new place which calls add place inside
  bool savePlace() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_title.isEmpty || _selectedImage == null || _pickedLocation == null) {
        return false;
      }

      Place place = Place(
          title: _title, image: _selectedImage!, location: _pickedLocation!);

      ref.read(favoritePlacesProvider.notifier).addPlace(place);

      // addPlace(place); // call to addplace
      return true;
    }
    return false;
  }

  void setFormDefaults() {
    _selectedImage = null;
    _title = "";
    _pickedLocation = null;
    notifyListeners();
  }
}

final formProvider = ChangeNotifierProvider<FormNotifier>(
  (ref) => FormNotifier(ref),
);
