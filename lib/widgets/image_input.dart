import 'dart:io';
// import 'package:favorite_places/providers/fav_places_provider.dart';
import 'package:favorite_places/providers/form_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends ConsumerStatefulWidget {
  const ImageInput({super.key});

  @override
  ConsumerState<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends ConsumerState<ImageInput> {
  // File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) {
      return;
    }

    var formReader = ref.read(formProvider);

    formReader.setImage(File(pickedImage.path));
  }

  @override
  Widget build(BuildContext context) {
    var formWatcher = ref.watch(formProvider);

    Widget content = TextButton.icon(
      icon: const Icon(Icons.camera),
      label: const Text('Take Picture'),
      onPressed: _takePicture,
    );

    if (formWatcher.selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          formWatcher.selectedImage!,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
