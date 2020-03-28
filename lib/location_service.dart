import 'dart:async';

import 'package:geolocator/geolocator.dart';

///
/// Class that wraps whatever location package is used
///
class LocationServices {

  StreamController<GeoCoordinates> continuousGeoCoordinates;

  static Future<bool> isAvailable() async {
    GeolocationStatus geolocationStatus = await Geolocator().checkGeolocationPermissionStatus();
    if (geolocationStatus == GeolocationStatus.granted)
      return true;
    return false;
  }

  Future<GeoCoordinates> getGeoCoordinates() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return GeoCoordinates(position.latitude, position.longitude, position.altitude);
  }

  void liveGeoCoordinates() {
    var geoLocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    geoLocator.getPositionStream(locationOptions).listen(
      (Position position) {
        continuousGeoCoordinates.add(GeoCoordinates(position.latitude, position.longitude, position.altitude));
    });
  }
}

///
/// Dummy class to keep location specific data
///
class GeoCoordinates {
  num latitude, longitude, altitude;
  // plus some datetime maybe

  GeoCoordinates(this.latitude, this.longitude, this.altitude);
}