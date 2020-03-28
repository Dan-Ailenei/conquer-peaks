import 'package:conquerpeaksfe/location_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:geolocator/geolocator.dart';

class MockGeoLocator extends Mock implements Geolocator {}

void main() {
  group('isAvailable', () {
    test('Return true if GeoLocationStatus is granted', () async {
//      final mockGeoLocator = MockGeoLocator();
//      when(await mockGeoLocator.checkGeolocationPermissionStatus()).thenReturn(GeolocationStatus.granted);
      expect(await LocationServices.isAvailable(), true);
    });
//    test('Return false if GeoLocationStatus is denied', () async {
//      var locationServices = LocationServices();
//      when(await Geolocator().checkGeolocationPermissionStatus()).thenReturn(GeolocationStatus.denied);
//      expect(await locationServices.isAvailable(), false);
//    });
//    test('Return false if GeoLocationStatus is disabled', () async {
//      var locationServices = LocationServices();
//      when(await Geolocator().checkGeolocationPermissionStatus()).thenReturn(GeolocationStatus.disabled);
//      expect(await locationServices.isAvailable(), false);
//    });
  });
}