// import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlacesNotifier extends StateNotifier<List<Place>> {
  FavoritePlacesNotifier() : super([]);

  // late Place place;

  // File? _selectedImage;
  // String _title = ""; // form title field
  // final _formKey = GlobalKey<FormState>(); // form key

  // GlobalKey<FormState> get formKey => _formKey;

  // String get title => _title; // form title getter

  // File? get selectedImage => _selectedImage; // getter for image

  // void setImage(File? image) {
  //   _selectedImage = image;
  // }

  // // form title setter
  // void setTitle(String title) {
  //   _title = title;
  // }

  // adding a new place
  void addPlace(Place place) {
    state = [place, ...state];
  }

  // removing a place
  void removePlace(Place place) {
    state = state.where((p) => p.id != place.id).toList();
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesNotifier, List<Place>>((ref) {
  return FavoritePlacesNotifier();
});
