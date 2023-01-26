import 'package:module3/data.vos/vos/genre_vo.dart';
import 'package:module3/persistence/daos/genre_dao.dart';

class GenreDaoImplMock extends GenreDao{

  Map<int,GenreVO> genreListFromDatabaseMock = {};

  @override
  List<GenreVO> getAllGenres() {
    return genreListFromDatabaseMock.values.toList();
  }

  @override
  void saveAllGenres(List<GenreVO> genreList) {
    return genreList.forEach((genre) {
      genreListFromDatabaseMock[genre.id] = genre;
    });
  }


}