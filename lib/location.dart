import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationDetailsPage extends StatelessWidget {
  final LatLng location;
  final double distanceFromCurrent;

  const LocationDetailsPage({
    Key? key,
    required this.location,
    required this.distanceFromCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Latitude: ${location.latitude}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Longitude: ${location.longitude}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Distance from Current Location: ${distanceFromCurrent.toStringAsFixed(2)} meters',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to Map'),
            ),
          ],
        ),
      ),
    );
  }
}
