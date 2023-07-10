import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';

class MapPage extends StatefulWidget {
  MapPage();

  @override
  State<StatefulWidget> createState() {
    return _MapPage();
  }
}

class _MapPage extends State<MapPage> {
  int flag = 0;
  Timer? _timer;

  Map<String, dynamic> coordinates = {"x": 17.37582, "y": 78.48539};

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      try {
        DatabaseReference ref = FirebaseDatabase.instance.ref("latlong");
        ref.onValue.listen((event) {
          final a = event.snapshot.value as Map<dynamic, dynamic>;
          if (a != null) {
            setState(() {
              flag++;
              coordinates["x"] = a["x"] as double;
              coordinates["y"] = a["y"] as double;
            });
          }
        });
      } catch (error) {
        print(error);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      if (index == 1) {
        Navigator.pushReplacementNamed(context, '/feed');
      } else if (index == 0) {
        Navigator.pushReplacementNamed(context, '/login');
      } else if (index == 3) {
        Navigator.pushReplacementNamed(context, '/speech');
      } else if (index == 2) {
        Navigator.pushReplacementNamed(context, '/alerts');
      } else if (index == 5) {
        Navigator.pushReplacementNamed(context, '/open');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Location"),
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: FlutterMap(
          options: MapOptions(
              center: LatLng(coordinates["x"], coordinates["y"]), zoom: 16),
          layers: [
            TileLayerOptions(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
            MarkerLayerOptions(markers: [
              Marker(
                  width: 30.0,
                  height: 30.0,
                  point: LatLng(coordinates["x"], coordinates["y"]),
                  builder: (ctx) => Container(
                          child: Container(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      )))
            ])
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xBBC2C2C4),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.mic,
            ),
            label: 'login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.directions_car,
            ),
            label: 'Vehicles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_alert),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Geofence',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
