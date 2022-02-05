import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers/locatioon_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  @override
  final Function onSelectPlace;

  const LocationInput({this.onSelectPlace});
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _prviewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    setState(() {
      _prviewImageUrl = LocationHelper.generateLocationPreviewImage(
          latitude: locData.latitude, longitude: locData.longitude);
    });
    widget.onSelectPlace(locData.latitude, locData.longitude);
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation =
        await Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => MapScreen(
                  isSelecting: true,
                )));

    if (selectedLocation == null) {
      return;
    }
    setState(() {
      _prviewImageUrl = LocationHelper.generateLocationPreviewImage(
          latitude: selectedLocation.latitude,
          longitude: selectedLocation.longitude);
    });
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            child: _prviewImageUrl == null
                ? Text(
                    'No location selected',
                    textAlign: TextAlign.center,
                  )
                : Image.network(
                    _prviewImageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FlatButton.icon(
            onPressed: _getCurrentUserLocation,
            icon: Icon(Icons.location_on),
            label: Text('Current location'),
            textColor: Theme.of(context).primaryColor,
          ),
          FlatButton.icon(
            onPressed: _selectOnMap,
            icon: Icon(Icons.map),
            label: Text('Select Map'),
            textColor: Theme.of(context).primaryColor,
          )
        ]),
      ],
    );
  }
}
