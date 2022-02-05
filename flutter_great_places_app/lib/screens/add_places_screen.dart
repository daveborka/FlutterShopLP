import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../widgets/image_input.dart';
import '../providers/great_places.dart';
import '../widgets/location_input.dart';
import '../models/places.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/add-place";
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation pickedLocation;
  void _selectPlace(double lat, double long) {
    pickedLocation = PlaceLocation(latitude: lat, longitude: long);
  }

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }

    Provider.of<GreatePlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage, pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Great Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Padding(
            padding: EdgeInsets.all(10),
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
                SizedBox(
                  height: 10,
                ),
                LocationInput(
                  onSelectPlace: _selectPlace,
                )
                // FlatButton(onPressed: () {}, child: child)
              ],
            ),
          ))),
          RaisedButton.icon(
            onPressed: savePlace,
            icon: Icon(Icons.add),
            label: Text('Add Plcae'),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }
}
