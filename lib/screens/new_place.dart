import 'package:favorite_places/providers/fav_places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/widgets/image_input.dart';

class NewPlace extends ConsumerWidget {
  const NewPlace({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var favPlaces = ref.read(favoritePlacesProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new place'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: favPlaces.formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return "Must be between 1 and 50 characters.";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    favPlaces.setTitle(value ?? "");
                  },
                ),
                const SizedBox(height: 16),
                const ImageInput(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        favPlaces.formKey.currentState!.reset();
                      },
                      child: const Text('Reset'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        favPlaces.savePlace();
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Place'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
