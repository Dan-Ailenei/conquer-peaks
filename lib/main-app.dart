import 'package:conquerpeaksfe/ui/MapPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conquerpeaksfe/bloc/location_bloc.dart';

void main() => runApp(ConquerPeaksApp());

class ConquerPeaksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conquer Peaks App',
      home: BlocProvider(
        builder: (context) => LocationBloc(),
        child: MapPage(),
      ),
    );
  }
}