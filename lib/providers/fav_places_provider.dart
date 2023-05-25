import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlacesNotifier extends StateNotifier<List<Place>> {
  FavoritePlacesNotifier() : super([]);

  late Place place;

  String _title = ""; // form title field
  final _formKey = GlobalKey<FormState>(); // form key

  GlobalKey<FormState> get formKey => _formKey;

  String get title => _title; // form title getter

  void setTitle(String title) {
    // form title setter
    _title = title;
  }

  void addPlace(Place place) {
    // adding a new place
    state = [place, ...state];
  }

  void removePlace(Place place) {
    // removing a place
    state = state.where((p) => p.id != place.id).toList();
  }

  void savePlace() {
    // used in form to save a new place which calls add place inside
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      place = Place(title: title);

      addPlace(place); // call to addplace
    }
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesNotifier, List<Place>>((ref) {
  return FavoritePlacesNotifier();
});
