import 'package:flutter/material.dart';
import 'package:module3/data.vos/models/movie_model_impl.dart';

import '../data.vos/models/movie_model.dart';
import '../data.vos/vos/credit_vo.dart';
import '../data.vos/vos/movie_vo.dart';

class MovieDetailsBloc extends ChangeNotifier{
  
  /// State
  MovieVO? mMovie;
  List<CreditVO> mActorsList =[];
  List<CreditVO> mCreatorList = [];
  List<MovieVO>? mRelatedMoviesList; 
  
  
  ///Model
  MovieModel mMovieModel = MovieModelImpl();
  
  MovieDetailsBloc(int movieId,[MovieModel? movieModel]){
    if(movieModel != null){
      mMovieModel = movieModel;
    }

    ///Movie Details
    mMovieModel.getMovieDetails(movieId).then((movie){
      this.mMovie = movie;
      this.getRelatedMovies(movie?.genres?.first.id ?? 0);
      notifyListeners();
    });

    ///Movie Details Database
    mMovieModel.getMovieDetailsFromDatabase(movieId).then((movie){
      this.mMovie = movie;
      notifyListeners();
    });
    


    ///Credits
    mMovieModel.getCreditsByMovie(movieId).then((creditList){
           this.mCreatorList = creditList.where((credit) => credit.isCreator() == true).toList();
           this.mActorsList = creditList.where((credit) => credit.isActor() == true).toList();
           print("Actor List :: ${mActorsList.map((e) => e.toJson())}");
           print("Creator List ::: ${mCreatorList.map((e) => e.toJson())}");
           notifyListeners();
    });
  }
  ///Related Movies From Database
  void getRelatedMovies(int genreId){
    mMovieModel.getMoviesByGenre(genreId).then((relatedMovies){
      mRelatedMoviesList = relatedMovies;
      notifyListeners();
    });
  }

}