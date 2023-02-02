import 'package:geolocator/geolocator.dart';

class Coord {
  double? latitude;
  double? longitude;
}

Future<void> getPermission() async {
  await Geolocator.requestPermission();
}

Future<Coord> getCurrentLocation() async {
  Coord coord = Coord();
  try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    coord.latitude = position.latitude;
    coord.longitude = position.longitude;
    print("LONGITUDE:${coord.longitude}");
    return coord;
  } catch (e) {
    print(e);
    return coord;
  }
}
