import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();
}

class GetLocation extends LocationEvent {
  @override
  List<Object> get props => [];
}

class ListenLocation extends LocationEvent {
  @override
  List<Object> get props => [];
}

class CancelListenLocation extends LocationEvent {
  @override
  List<Object> get props => [];
}