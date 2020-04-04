import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

///
/// Dummy class to keep location specific data
///
class GeoCoordinates extends Equatable {
  final num latitude, longitude, altitude;
  // plus some datetime maybe

  GeoCoordinates({
    @required this.latitude,
    @required this.longitude,
    @required this.altitude});

  @override
  List<Object> get props => [latitude, longitude, altitude];
}