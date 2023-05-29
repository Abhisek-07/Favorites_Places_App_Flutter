import 'package:favorite_places/providers/fav_places_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/screens/new_place.dart';

import 'package:favorite_places/widgets/places_list.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritePlaces = ref.watch(favoritePlacesProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const NewPlace(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
        title: const Text('Your Favorite Places'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: PlacesList(
          places: favoritePlaces,
        ),
      ),
    );
  }
}
