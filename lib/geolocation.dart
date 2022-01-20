import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String myPosition = '';
  LocationPermission? permission;

  @override
  void initState() {
    getPosition().then((myPos) {
      myPosition = 'Latitude: ' +
          myPos.latitude.toString() +
          ' - Longitude: ' +
          myPos.longitude.toString();
      setState(() {
        myPosition = myPosition;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget myWidget;
    if (myPosition == '') {
      myWidget = const CircularProgressIndicator();
    } else {
      myWidget = Text(myPosition);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Location'),
      ),
      body: Center(
        child: myWidget,
      ),
    );
  }

  Future getPosition() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Lacation permission denied');
      }
      Position? position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return position;
    }
  }
}
