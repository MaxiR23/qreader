import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qreader/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  
  final map = MapController();

  String typeMapa = 'streets';

  @override
  Widget build(BuildContext context) {
    
    final ScanModel scans = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Coordenadas'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location), 
            onPressed: (){
              map.move(scans.getLatLng(), 15);
            }
          )
        ],
      ),
      body: _createFMap(scans),
      floatingActionButton: _createFAB(context),
    );
  }

  _createFMap(ScanModel scans) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scans.getLatLng(),
        zoom: 15,
      ),
      layers: [
        _createMap(),
        _createMarker(scans)
      ],
    );
  }

  _createMap() {
    return TileLayerOptions(
      urlTemplate:'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions:{
        'accessToken': 'pk.eyJ1IjoibXJlYm9sbyIsImEiOiJjazczaDd2ajUwYjh3M2VxcWo1ZGIwMzFhIn0.ALTkZCzkEyfN4xSCUo19-g',
        'id': 'mapbox.$typeMapa',
      },  
    );
  }

  _createMarker(ScanModel scans) {
    return MarkerLayerOptions(
      markers: <Marker> [
        Marker(
          width: 100.0,
          height: 100.0,
          point: scans.getLatLng(),
          builder: (context) => Container(
            child: Icon(
              Icons.location_on,
              size: 70.0,
              color: Theme.of(context).primaryColor,
            ),
          )
        )
      ]
    );
  }

  Widget _createFAB(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        //streets, dark, light, outdoors, satellite
        if (typeMapa == 'streets') {
          typeMapa = 'dark';
        } else if (typeMapa == 'dark'){
          typeMapa = 'light';
        } else if (typeMapa == 'light'){
          typeMapa = 'outdoors';
        } else if (typeMapa == 'outdoors'){
          typeMapa = 'satellite';
        } else {
          typeMapa = 'streets';
        }

        setState(() {});
      }
    );
  }
}