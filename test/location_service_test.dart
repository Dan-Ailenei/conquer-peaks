import 'package:conquerpeaksfe/location_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:geolocator/geolocator.dart';

class MockGeoLocator extends Mock implements Geolocator {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('isAvailable', () {
    MockGeoLocator mockGeoLocator;
    LocationService locationService;
    setUpAll(() {
      mockGeoLocator = MockGeoLocator();
      locationService = LocationService()..apiLocation = mockGeoLocator;
    });
    test('Return true if GeoLocationStatus is granted', () async {
      when(mockGeoLocator.checkGeolocationPermissionStatus()).thenAnswer((_) async => GeolocationStatus.granted);
      expect(await locationService.isAvailable(), true);
    });
    test('Return false if GeoLocationStatus is denied, disabled, restricted or unknown', () async {
      when(mockGeoLocator.checkGeolocationPermissionStatus()).thenAnswer((_) async => GeolocationStatus.denied);
      expect(await locationService.isAvailable(), false);
      when(mockGeoLocator.checkGeolocationPermissionStatus()).thenAnswer((_) async => GeolocationStatus.disabled);
      expect(await locationService.isAvailable(), false);
      when(mockGeoLocator.checkGeolocationPermissionStatus()).thenAnswer((_) async => GeolocationStatus.restricted);
      expect(await locationService.isAvailable(), false);
      when(mockGeoLocator.checkGeolocationPermissionStatus()).thenAnswer((_) async => GeolocationStatus.unknown);
      expect(await locationService.isAvailable(), false);
    });
  });
}
