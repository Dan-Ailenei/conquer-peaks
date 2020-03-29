import 'package:conquerpeaksfe/model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double lat = 1;
  double long = 0;
  double alt = -3;
  String placeMark = '';

  void _incrementCounter() {
    Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      Location(datetime: DateTime.now()).save();
      setState(() {
        lat = position.latitude;
        long = position.longitude;
        alt = position.altitude;
      });
      Geolocator().placemarkFromPosition(position).then((List<Placemark> placeMarks) {
        setState(() {
          placeMark = 'Hello';
//          placeMarks.forEach((place) {
//            placeMark += place.toJson().toString();
//          });
        });
      });
    });
  }

  void _refresh() async{
    final locationList = await Location().select().toList();
    final location = locationList.elementAt(0);
    setState(()  {
       placeMark = 'Saved location on ${location.datetime}\n${location.data}';
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _refresh();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your position:',
            ),
            Text(
              '$lat ,$long $alt',
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              'Placemark: $placeMark',
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
