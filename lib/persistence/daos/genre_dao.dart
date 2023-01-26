import 'package:hive/hive.dart';
import 'package:module3/persistence/daos/hive_constants.dart';

import '../../data.vos/vos/genre_vo.dart';

abstract class GenreDao{


  void saveAllGenres(List<GenreVO>genreList);

  List<GenreVO> getAllGenres();


}