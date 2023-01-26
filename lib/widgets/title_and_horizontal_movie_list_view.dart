import 'package:flutter/material.dart';
import 'package:module3/widgets/smart_list_view.dart';
import 'package:module3/widgets/title_text.dart';

import '../data.vos/vos/movie_vo.dart';
import '../pages/home_page.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewitems/movie_view.dart';

class TitleAndHorizontalMovieListView extends StatelessWidget {
  final Function(int) onTapMovie;
  final List<MovieVO> mNowPlayingMovieList;
  final String title;
  final Function onListEndReached;

  TitleAndHorizontalMovieListView(this.onTapMovie, this.mNowPlayingMovieList,
      {required this.title, required this.onListEndReached});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: TitleText(title),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        HorizontalMovieListView(
          (movieId) {
            this.onTapMovie(movieId);
          },
          movieList: mNowPlayingMovieList,
          onListEndReached: () {
            this.onListEndReached();
          },
        )
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int) onTapMovie;
  final List<MovieVO> movieList;
  final Function onListEndReached;

  HorizontalMovieListView(this.onTapMovie,
      {required this.movieList, required this.onListEndReached});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MOVIE_LIST_HEIGHT,
      child: (movieList != null)
          // ? ListView.builder(
          // scrollDirection: Axis.horizontal,
          // padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          // itemCount: movieList.length,
          // itemBuilder: (BuildContext context, int index) {
          //   return MovieView((movieId) {
          //     this.onTapMovie(movieId);
          //   }, movieList[index]);
          // })
          ? SmartHorizontalListView(
              itemCount: movieList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return MovieView((movieId) {
                  this.onTapMovie(movieId);
                }, movieList[index]);
              },
              padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
              onListEndReached: () {
                this.onListEndReached();
              })
          : Center(child: CircularProgressIndicator()),
    );
  }
}
