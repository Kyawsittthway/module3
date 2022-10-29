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
  
  
  ///Model
  MovieModel mMovieModel = MovieModelImpl();
  
  MovieDetailsBloc(int movieId){
    ///Movie Details
    mMovieModel.getMovieDetails(movieId).then((movie){
      this.mMovie = movie;
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
           notifyListeners();
    });
  }
  
}