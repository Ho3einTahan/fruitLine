import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng latLng = const LatLng(33.9955811, 51.4268625);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String url =
              'https://www.google.com/maps/search/?api=1&query=${latLng.latitude},${latLng.longitude}';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
        child: const Icon(Icons.location_on),
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: const LatLng(33.9955811, 51.4268625),
                initialZoom: 15.0,
                onTap: (tapPosition, point) {
                  latLng = point;
                  setState(() {});
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(latLng.latitude, latLng.longitude),
                      child: Container(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
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
                onPressed: () {},
                child: const Text(
                  'افزودن مسیر',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
