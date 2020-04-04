import 'package:conquerpeaksfe/bloc/location.dart';
import 'package:conquerpeaksfe/bloc/location_bloc.dart';
import 'package:conquerpeaksfe/bloc/location_event.dart';
import 'package:conquerpeaksfe/bloc/location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocListener<LocationBloc, LocationState> (
          listener: (context, state) {
            if (state is LocationError) {
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text(state.message),));
            }
          },
          child: BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              if (state is LocationInitial)
                return buildInitialInput();
              else if (state is LocationLoading)
                return buildLoading();
              else if (state is LocationLoaded)
                return buildColumnWithData(context, state.geoCoordinates);
              else return buildInitialInput(); // error
            }
          ),
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: GetLocationButton(),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(BuildContext context, GeoCoordinates geoCoordinates) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          'Current coordinates',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'Lat: ' + geoCoordinates.latitude.toString() +
            '\nLong: ' + geoCoordinates.longitude.toString() +
            '\nAlt: ' + geoCoordinates.altitude.toString(),
          style: TextStyle(fontSize: 13),
        ),
        GetLocationButton(),
      ],
    );
  }
}

class GetLocationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: RaisedButton(
        onPressed: () => makeCall(context),
        child: Text(
          'Get Location',
          style: TextStyle(fontSize: 20),
        ),
      )
    );
  }

  void makeCall(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.add(GetLocation());
  }
}