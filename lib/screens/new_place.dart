// import 'package:favorite_places/providers/fav_places_provider.dart';
import 'package:favorite_places/providers/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';

class NewPlace extends ConsumerWidget {
  const NewPlace({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var formWatcher = ref.watch(formProvider);

    return WillPopScope(
      onWillPop: () async {
        formWatcher.setFormDefaults();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add a new place'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: formWatcher.formKey,
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
                      formWatcher.setTitle(value!);
                    },
                  ),
                  const SizedBox(height: 16),
                  const ImageInput(),
                  const SizedBox(height: 16),
                  LocationInput(),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          formWatcher.formKey.currentState!.reset();
                          formWatcher.setFormDefaults();
                        },
                        child: const Text('Reset'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (formWatcher.savePlace()) {
                            formWatcher.setFormDefaults();
                            Navigator.of(context).pop();
                          }
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
      ),
    );
  }
}
