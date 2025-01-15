import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gmap/location.dart';
import 'package:gmap/locationService.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
// import 'location_details_page.dart';
// import 'location_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double? lat, lon;
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const LatLng _defaultLocation = LatLng(30.741482, 76.768066);
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: _defaultLocation,
    zoom: 13,
  );

  LatLng _currentLatLng = _defaultLocation;
  final LocationServices _locationServices = LocationServices();
  Set<Marker> _markers = {
    Marker(
      markerId: const MarkerId('defaultLocation'),
      position: _defaultLocation,
      infoWindow: const InfoWindow(
        title: 'Default Location',
        snippet: 'Starting point before location update',
      ),
    ),
  };

  Future<void> _getCurrentLocation() async {
    Position? position = await _locationServices.getCurrentLocation();
    if (position != null) {
      // Shift the location slightly to simulate movement
      lat = position.latitude + (Random().nextDouble() - 0.5) * 0.001;
      lon = position.longitude + (Random().nextDouble() - 0.5) * 0.001;

      setState(() {
        _currentLatLng = LatLng(lat!, lon!);
        _markers.clear();

        // Marker for the updated current location
        _markers.add(
          Marker(
            markerId: const MarkerId('currentLocation'),
            position: _currentLatLng,
            infoWindow: const InfoWindow(
              title: 'Your Location',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        );
      });

      _generateRandomNearbyLocations();

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _currentLatLng,
          zoom: 13.0,
        ),
      ));
    }
  }

  void _generateRandomNearbyLocations() {
    final Random random = Random();
    const double offsetRange = 0.03;

    for (int i = 0; i < 5; i++) {
      final double latOffset = (random.nextDouble() - 0.5) * offsetRange;
      final double lonOffset = (random.nextDouble() - 0.5) * offsetRange;

      final LatLng randomLocation = LatLng(
        _currentLatLng.latitude + latOffset,
        _currentLatLng.longitude + lonOffset,
      );

      final double distance = _calculateDistance(_currentLatLng, randomLocation);

      _markers.add(Marker(
        markerId: MarkerId('randomLocation$i'),
        position: randomLocation,
        infoWindow: InfoWindow(
          title: 'Nearby Location ${i + 1}',
          snippet: 'Distance: ${distance.toStringAsFixed(2)} meters',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LocationDetailsPage(
                  location: randomLocation,
                  distanceFromCurrent: distance,
                ),
              ),
            );
          },
        ),
      ));
    }
    setState(() {});
  }

  double _calculateDistance(LatLng start, LatLng end) {
    return Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
  }

  Future<void> _saveAllLocations() async {
    Map<String, dynamic> locationData = {
      'current_location': {
        'latitude': _currentLatLng.latitude,
        'longitude': _currentLatLng.longitude,
      },
      'nearby_location': _markers
          .where((marker) => marker.markerId.value != 'currentLocation')
          .map((marker) => {
        'latitude': marker.position.latitude,
        'longitude': marker.position.longitude,
      }).toList(),
    };

    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('locations').add(locationData);
      print('Locations saved successfully!');
    } catch (e) {
      print('Error saving locations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: const Text("Google Map",
            style: TextStyle(
              color: Colors.white
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers,
            ),
            Positioned(
              bottom: 70,
              left: 20,
              child: TextButton(
                onPressed: _getCurrentLocation,
                child: const CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.location_on, color: Colors.red),
                ),
              ),
            ),
            Positioned(
              bottom: 70,
              right: 100,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )),
                ),
                onPressed: _saveAllLocations,
                child: const Text(
                  'Save All Locations',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
