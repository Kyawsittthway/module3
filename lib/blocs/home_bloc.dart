import 'dart:async';

import 'package:flutter/material.dart';
import 'package:module3/data.vos/models/movie_model.dart';
import 'package:module3/data.vos/models/movie_model_impl.dart';
import '../data.vos/vos/actor_vo.dart';
import '../data.vos/vos/genre_vo.dart';
import '../data.vos/vos/movie_vo.dart';

class HomeBloc extends ChangeNotifier{

  ///State
  List<MovieVO>mNowPlayingMovieList=[];
  List<MovieVO>mPopularMoviesList= [];
  List<GenreVO>mGenreList=[];
  List<ActorVO>mActors=[];
  List<MovieVO>mShowCaseMovieList=[];
  List<MovieVO>mMoviesByGenreList=[];

  ///Page
  int pageForNowPlayingMovies = 1;

  ///Model
  MovieModel mMovieModel = MovieModelImpl();

  HomeBloc([MovieModel? movieModel]){
    ///Set Mock Model For Test Data
    if(movieModel != null){
      mMovieModel = movieModel;
    }
    /// Now Playing Movies Database
    mMovieModel.getNowPlayingMoviesFromDatabase().listen((movieList){
      print("this is getting triggered!");
     mNowPlayingMovieList = movieList;
     if(mNowPlayingMovieList?.isNotEmpty ?? false){
       mNowPlayingMovieList?.sort((a,b)=> a.id - b.id);
     }
      // print("Now Playing Movies Database :: ${mNowPlayingMovieList}");
     notifyListeners();
    }).onError((error){
      print("Error from getNowPlayingMoviesFromDatabase :: " + error.toString());
    });

    /// Popular Movies Database
    mMovieModel.getPopularMoviesFromDatabase().listen((movieList){
      mPopularMoviesList = movieList;
      // print("Popular Movies Database :: ${mPopularMoviesList}");
      notifyListeners();
    }).onError((error){
      print("Error from getPopularMoviesFromDatabase :: " + error.toString());
    });

    /// Top Rated Movies Database
    mMovieModel.getTopRatedMoviesFromDatabase().listen((movieList){
      mShowCaseMovieList = movieList;
      // print("Top Rated Movies Database :: ${mShowCaseMovieList}");
      notifyListeners();
    }).onError((error){
      print("Error from getTopRatedMoviesFromDatabase :: " +error.toString());
    });



    ///Genres
    mMovieModel.getGenres().then((genres){
      mGenreList = genres;

      ///Movies by Genres
      if(mGenreList?.isNotEmpty ?? false){
        getMoviesByGenreAndRefresh(mGenreList.first.id ?? 0);
      }
    }).catchError((error){
      print("Error from _getMoviesByGenreAndRefresh :: " +error.toString());
    });

    ///Genres Database
    mMovieModel.getGenresFromDatabase().then((genreList){
      mGenreList = genreList;

      ///Movies by Genres
      getMoviesByGenreAndRefresh(mGenreList.first.id);
    }).catchError((error){
      print("Error from _getMoviesByGenreAndRefresh :: " +error.toString());
    });

    ///Actors
    mMovieModel.getActors(1).then((actorList){
      mActors = actorList;
      notifyListeners();
    }).catchError((error){
      print("Error from getActors :: " +error.toString());
    });

    ///Actors Database
    mMovieModel.getAllActorsFromDatabase().then((actorList){
      mActors = actorList;
      notifyListeners();
    }).catchError((error){
      print("Error from getAllActorsFromDatabase :: " +error.toString());
    });


  }

  void getMoviesByGenreAndRefresh(int genreId){
    mMovieModel.getMoviesByGenre(genreId).then((moviesByGenre){
      mMoviesByGenreList = moviesByGenre;
      notifyListeners();
    }).catchError((error){
      print("Error from _getMoviesByGenreAndRefresh :: " +error.toString());
    });
  }

  void onNowPlayingMovieListEndReached(){
    this.pageForNowPlayingMovies += 1;
    mMovieModel.getPopularMovies(pageForNowPlayingMovies);
  }


}