import 'package:flutter/material.dart';
import 'package:qreader/src/pages/home_page.dart';
import 'package:qreader/src/pages/mapa_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QReader',
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context) => HomePage(),
        'mapa' : (BuildContext context) => MapaPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.blueGrey
      ),
    );
  }
}