import 'package:conquerpeaksfe/bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'location.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  Geolocator locationAPI = Geolocator();

  @override
  LocationState get initialState => LocationInitial();

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    yield LocationLoading();
    if (event is GetLocation) {
      try {
        final location = await fetchLocation();
        yield LocationLoaded(location);
      } on Error {
        yield LocationError("Some error occurred :(");
      }
    } else if (event is ListenLocation) {
      var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
      await for (final position in locationAPI.getPositionStream(locationOptions)) {

      }
    }
  }

  Future<bool> isAvailable() async {
    GeolocationStatus geolocationStatus = await this.locationAPI.checkGeolocationPermissionStatus();
    if (geolocationStatus == GeolocationStatus.granted)
      return true;
    return false;
  }

  Future<GeoCoordinates> fetchLocation() async {
    var position = await this.locationAPI
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return GeoCoordinates(
        latitude: position.latitude,
        longitude: position.longitude,
        altitude: position.altitude);
  }

}