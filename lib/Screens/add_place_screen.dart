import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/image_input.dart';
import 'package:provider/provider.dart';
import '../Providers/great_places.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place-screen';
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    print(_titleController.text.isEmpty);
    print(_pickedImage == null);
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    } else {
      Provider.of<GreatPlaces>(context, listen: false)
          .addPlace(_titleController.text, _pickedImage!);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ImageInput(
                    onSelectImage: _selectImage,
                  ),
                ],
              ),
            ),
          )),
          ElevatedButton.icon(
              onPressed: _savePlace,
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).accentColor),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              icon: Icon(Icons.add),
              label: Text('Add Place'))
        ],
      ),
    );
  }
}
