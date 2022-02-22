import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> getPosition() async {

    Position? position = await Geolocator.getLastKnownPosition();
  print(position);

  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
    //return await Geolocator.getCurrentPosition();
    final positionOne = await Geolocator.getCurrentPosition();
    getAddressFromLatLong(positionOne.latitude, positionOne.longitude);
  return Position(longitude: 90.316169, latitude: 43.992556, accuracy: 0, altitude: 0,heading: 0,speed: 0, speedAccuracy: 0,timestamp: DateTime(2022));
}

Future<Placemark> getAddressFromLatLong(double latitude, double longitude)async {

  List<Placemark>placemarks = await placemarkFromCoordinates(latitude, longitude);
  final address = placemarks.map((placeMark) {
      String? name = placeMark.name;
      String? subLocality = placeMark.subLocality;
      String? locality = placeMark.locality;
      String? administrativeArea = placeMark.administrativeArea;
      String? postalCode = placeMark.postalCode;
      String? country = placeMark.country;
      String? address = " ${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";
      return address;
  });
  return placemarks.first;
}