import 'dart:developer';
import 'package:geolocator/geolocator.dart';

class LocationServices {
  Future<Position?> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      log("Location Permission Denied");
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        log("Location permission still denied.");
        return null;
      }
    }

    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    return currentPosition;
  }
}
