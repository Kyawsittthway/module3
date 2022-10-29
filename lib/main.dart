import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:module3/data.vos/models/movie_model_impl.dart';
import 'package:module3/data.vos/vos/actor_vo.dart';
import 'package:module3/data.vos/vos/base_actor_vo.dart';
import 'package:module3/data.vos/vos/collection_vo.dart';
import 'package:module3/data.vos/vos/credit_vo.dart';
import 'package:module3/data.vos/vos/date_vo.dart';
import 'package:module3/data.vos/vos/genre_vo.dart';
import 'package:module3/data.vos/vos/movie_vo.dart';
import 'package:module3/data.vos/vos/production_company_vo.dart';
import 'package:module3/data.vos/vos/production_country_vo.dart';
import 'package:module3/data.vos/vos/spoken_language_vo.dart';
import 'package:module3/network/retrofit_data_agent_impl.dart';
import 'package:module3/pages/home_page.dart';
import 'package:module3/pages/movie_details_page.dart';
import 'package:module3/persistence/daos/hive_constants.dart';
import 'package:scoped_model/scoped_model.dart';

import 'network/dio_movie_data_agent_impl.dart';
import 'network/http_movie_data_agent_impl.dart';

void main() async{
  await Hive.initFlutter();

  Hive.registerAdapter(ActorVOAdapter());
  Hive.registerAdapter(BaseActorVOAdapter());
  Hive.registerAdapter(CollectionVOAdapter());
  Hive.registerAdapter(CreditVOAdapter());
  Hive.registerAdapter(DateVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(ProductionCompanyVOAdapter());
  Hive.registerAdapter(ProductionCountryVOAdapter());
  Hive.registerAdapter(SpokenLanguageVOAdapter());

  await Hive.openBox<ActorVO>(BOX_NAME_ACTOR_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
  await Hive.openBox<GenreVO>(BOX_NAME_GENRE_VO);

//   RetrofitDataAgentImpl().getNowPlayingMovies(1);
// //  RetrofitDataAgentImpl().getPopularMovies(1);
//   RetrofitDataAgentImpl().getActors(1);
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ScopedModel(
      model: MovieModelImpl(),
      child: MaterialApp(
        title:'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity
        ),
        home:  HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

