import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  const ImageInput({super.key, required this.onSelectImage});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    /// Provides an easy way to pick an image/video from the image library,
    /// or to take a picture/video with the camera.
    final picker = ImagePicker();

    /// Returns a [PickedFile] with the image that was picked.
    /// The `source` argument controls where the image comes from. This can
    /// be either [ImageSource.camera] or [ImageSource.gallery].
    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) {
      return;
    }

    setState(() {
      //Get the path of the picked file, setState because we need to
      //show the image as soon as it is taken
      _storedImage = File(imageFile.path);
    });

    //*To find what location we have to store our image, this storage
    //*is specifically reserved for app data
    final appDirectory = await syspath.getApplicationDocumentsDirectory();

    //*It stores the image name given by the app
    final fileName = path.basename(imageFile.path);
    final savedImage =
        await _storedImage!.copy('${appDirectory.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.green,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
            child: TextButton.icon(
                onPressed: (() {
                  _takePicture();
                }),
                icon: const Icon(Icons.camera),
                label: const Text('Take Picture!')))
      ],
    );
  }
}
