import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  final String landId;
  final String landTitle;
  final String landImage;
  final String landDesc;
  final double landLat;
  final double landLon;
  final double landCLat;
  final double landCLon;

  const HomePage({
    @required this.landId,
    @required this.landTitle,
    @required this.landImage,
    @required this.landDesc,
    @required this.landLat,
    @required this.landLon,
    @required this.landCLat,
    @required this.landCLon,
  });
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _address1 = '';
  String _address2 = '';
  double _lat1;
  double _long1;
  double _lat2;
  double _long2;
  double distanceInMeters;

  void initState() {
    super.initState();
    getCurrentAddress(
      widget.landCLat,
      widget.landCLon,
    );
    getLandLocation(
      widget.landLat,
      widget.landLon,
    );
    _lat1 = widget.landLat;
    _long1 = widget.landLon;
    _lat2 = widget.landCLat;
    _long2 = widget.landCLon;
    distanceInMeters =
        Geolocator.distanceBetween(_lat1, _long1, _lat2, _long2) / 1000;
  }

  getLandLocation(
    double l1,
    double l2,
  ) async {
    final coordinates = new Coordinates(l1, l2);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      _address1 = address.first.locality;

      print(_address1);
      _lat1 = l1;
      _long1 = l2;
    });
  }

  getCurrentAddress(
    double _l1,
    double _l2,
  ) async {
    final coordinates = new Coordinates(_l1, _l2);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      _address2 = address.first.locality;

      print(_address2);
      _lat2 = _l1;
      _long2 = _l2;
    });
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Center(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: Image.network(widget.landImage),
            ),
            Text(
              widget.landTitle,
              style: TextStyle(
                fontSize: 35,
                color: Colors.indigo[900],
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.landDesc,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.indigo[900],
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Land Location is ' + _address1,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Your Location is ' + _address2,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Distance ' + distanceInMeters.toStringAsFixed(1) + ' Km.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
