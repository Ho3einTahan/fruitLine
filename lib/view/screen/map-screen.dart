import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? latLng;
  StreamSubscription<Position>? _positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  // Function to get current location and subscribe to location changes
  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied.';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied, we cannot request permissions.';
    }

    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      setState(() {
        latLng = LatLng(position.latitude, position.longitude);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<LatLng?>(
        stream: _getCurrentLocationStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            LatLng? currentLatLng = snapshot.data;
            return _buildMap(currentLatLng);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Stream<LatLng?> _getCurrentLocationStream() async* {
    while (true) {
      if (latLng != null) {
        yield latLng;
      }
      await Future.delayed(Duration(seconds: 1));
    }
  }

  Widget _buildMap(LatLng? currentLatLng) {
    return Column(
      children: [
        Expanded(
          child: FlutterMap(
            options: MapOptions(
              center: currentLatLng ?? const LatLng(33.9955811, 51.4268625),
              zoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: currentLatLng == null
                    ? []
                    : [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: currentLatLng,
                          child: Container(
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.blue,
                              size: 50.0,
                            ),
                          ),
                        ),
                      ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xff3D5920),
              minimumSize: const Size(200, 55),
            ),
            onPressed: () {
              // Handle add route button press
              // Add your logic here for adding route or navigation
            },
            child: Text(
              'افزودن مسیر',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
