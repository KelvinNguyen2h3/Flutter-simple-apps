import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Sử dụng LatLng từ gói latlong
import 'package:geolocator/geolocator.dart'; // Thêm import cho gói geolocator

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GIS Map',
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatelessWidget {
  final List<Map<String, dynamic>> schools = [
    {
      "name": "THPT Giồng Ông Tố",
      "latitude": 10.785934448242188,
      "longitude": 106.7553482055664
    },
    {"name": "THPT Thủ Thiêm", "latitude": 10.7973, "longitude": 106.744},
    // Thêm các trường khác tương tự
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GIS Map'),
      ),
      body: FutureBuilder<Position>(
        future: getCurrentLocation(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FlutterMap(
              options: MapOptions(
                center: LatLng(
                  snapshot.data!.latitude, // Sử dụng ! để xác nhận rằng snapshot.data không null
                  snapshot.data!.longitude, // Sử dụng ! để xác nhận rằng snapshot.data không null
                ),
                zoom: 10.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                  'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: schools
                      .map(
                        (school) => Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(
                        school['latitude'],
                        school['longitude'],
                      ),
                      builder: (ctx) => Container(
                        child: Icon(
                          Icons.school,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  )
                      .toList(),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
