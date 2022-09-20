import 'package:flutter/material.dart';
import 'package:module3/network/retrofit_data_agent_impl.dart';
import 'package:module3/pages/home_page.dart';
import 'package:module3/pages/movie_details_page.dart';

import 'network/dio_movie_data_agent_impl.dart';
import 'network/http_movie_data_agent_impl.dart';

void main() {
  RetrofitDataAgentImpl().getNowPlayingMovies(1);
//  RetrofitDataAgentImpl().getPopularMovies(1);
  RetrofitDataAgentImpl().getActors(1);
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

