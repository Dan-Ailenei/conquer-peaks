import 'dart:async';

import 'package:geolocator/geolocator.dart';

///
/// Class that wraps whatever location package is used
///
class LocationService {

  StreamController<GeoCoordinates> continuousGeoCoordinates;
  dynamic apiLocation = Geolocator();

  Future<bool> isAvailable() async {
    GeolocationStatus geolocationStatus = await this.apiLocation.checkGeolocationPermissionStatus();
    if (geolocationStatus == GeolocationStatus.granted)
      return true;
    return false;
  }

  Future<GeoCoordinates> getGeoCoordinates() async {
    var position = await this.apiLocation
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return GeoCoordinates(position.latitude, position.longitude, position.altitude);
  }

  void liveGeoCoordinates() {
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    this.apiLocation.getPositionStream(locationOptions).listen(
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