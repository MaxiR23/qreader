import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:qreader/src/bloc/scan_bloc.dart';
import 'package:qreader/src/models/scan_model.dart';
import 'package:qreader/src/pages/direcciones_page.dart';
import 'package:qreader/src/pages/mapas_page.dart';
import 'dart:io';

import 'package:qreader/src/utils/utils.dart' as util;

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  int currentPage = 0;

  final _scanBloc = new ScanBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QReader'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever), 
            onPressed: (){
              _scanBloc.deleteAllScans();
            }
          )
        ],
      ),
      body: _callPages(currentPage),
      bottomNavigationBar: _createBNB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          scanQR(context);
        }
      ),
    );
  }

  _callPages(int currentPage) {
    switch(currentPage){
       case 0 : return MapasPage();
       case 1 : return DireccionesPage();

      default : return MapasPage(); 
    }  
  }

  Widget _createBNB() {
    return BottomNavigationBar(
      currentIndex: currentPage,
      onTap: (index){
        currentPage = index;
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Maps')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Directions')
        )
      ]
    );
  }

  scanQR(BuildContext context) async {

    String futureString;

    try {
       futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString = e.toString();
      futureString = null;
    }

    if (futureString != null) {
      final scan = new ScanModel(value:futureString);
      _scanBloc.addNewScan(scan);

      if (Platform.isIOS) {
      Future.delayed(Duration(milliseconds: 750));
      util.openScan(context, scan);
    } else {
      util.openScan(context, scan);
    }
   }
  }
}