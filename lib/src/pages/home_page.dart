import 'package:flutter/material.dart';
import 'package:qreader/src/pages/direcciones_page.dart';
import 'package:qreader/src/pages/mapas_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  int currentPage = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QReader'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever), 
            onPressed: (){}
          )
        ],
      ),
      body: _callPages(currentPage),
      bottomNavigationBar: _createBNB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){}
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
}