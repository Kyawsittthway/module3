import 'package:flutter/material.dart';
import 'package:module3/pages/home_page.dart';
import 'package:module3/pages/movie_details_page.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home:  HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

