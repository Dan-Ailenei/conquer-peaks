import 'package:equatable/equatable.dart';

import 'location.dart';

abstract class LocationState extends Equatable {
  const LocationState();
}

class LocationInitial extends LocationState {
  const LocationInitial();
  @override
  List<Object> get props => [];
}

class LocationLoading extends LocationState {
  const LocationLoading();
  @override
  List<Object> get props => [];
}

class LocationLoaded extends LocationState {
  final GeoCoordinates geoCoordinates;
  const LocationLoaded(this.geoCoordinates);
  @override
  List<Object> get props => [geoCoordinates];
}

class LocationError extends LocationState {
  final String message;
  const LocationError(this.message);
  @override
  List<Object> get props => [message];
}