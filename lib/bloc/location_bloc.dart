import 'dart:async';
import 'dart:developer' as developer;
import 'package:conquerpeaksfe/bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'location.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  Geolocator locationAPI = Geolocator();
  static bool _isCancelled = false;

  @override
  LocationState get initialState => LocationInitial();

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    yield LocationLoading();
    if (event is GetLocation) {
      developer.log('get location', name: 'conquer.peaks.app');
      try {
        final location = await fetchLocation();
        yield LocationLoaded(location);
      } on Error {
        yield LocationError("Some error occurred :(");
      }
    } else if (event is ListenLocation) {
      _isCancelled = false;
      var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
      developer.log('listen for location', name: 'conquer.peaks.app');
      yield* locationAPI.getPositionStream(locationOptions)
          .asyncMap((position) => LocationLoaded(
          GeoCoordinates(
              latitude: position.latitude,
              longitude: position.longitude,
              altitude: position.altitude)))
          .takeWhile((position) {return !_isCancelled;});
    } else if (event is CancelListenLocation) {
      developer.log('cancel listen location event received', name: 'conquer.peaks.app');
      _isCancelled = true;
      yield LocationInitial();
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
