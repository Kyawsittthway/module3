
import 'package:flutter_test/flutter_test.dart';
import 'package:module3/blocs/movie_details_bloc.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){
  group("Movie Detail Bloc Test",(){
    MovieDetailsBloc? movieDetailBloc;

    setUp((){
      movieDetailBloc = MovieDetailsBloc(1,MovieModelImplMock());
    });

    test("Fetch Movie Detail Test", (){
      expect(movieDetailBloc?.mMovie,getMockMoviesForTest().first);
    });

    test("Fetch Creators Test", (){
      expect(movieDetailBloc?.mCreatorList?.contains(getMockCredit()[1]),true);
    });

    test("Fetch Actor Test", (){
      expect(movieDetailBloc?.mCreatorList?.contains(getMockCredit().first),true);
    });
  });
}