import 'package:conquerpeaksfe/location_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:geolocator/geolocator.dart';

class MockGeoLocator extends Mock implements Geolocator {}

void main() {
  group('isAvailable', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    test('Return true if GeoLocationStatus is granted', () async {
      final mockGeoLocator = MockGeoLocator();
      final locationService = LocationServices()..apiLocation = mockGeoLocator;
      when(mockGeoLocator.checkGeolocationPermissionStatus()).thenAnswer((_) async => GeolocationStatus.granted);
      expect(await locationService.isAvailable(), true);
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
