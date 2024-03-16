// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_task/core/error/failure.dart';
import 'package:movie_app_task/core/helpers/constants.dart';
import 'package:movie_app_task/main.dart';
import 'package:movie_app_task/movies/data/data_source/movies_data_source.dart';
import 'package:movie_app_task/movies/data/models/details_movie_models.dart';
import 'package:movie_app_task/movies/data/models/discover_models.dart';
import 'package:movie_app_task/movies/data/repositories/movies_repository.dart';


void main() {
  const channelName = 'com.example.movie_app_task/native';
  MovieDataSource moviesDataSource = MovieDataSourceImpl();
  int movie_id = 1011985;
  MethodChannel _channel = MethodChannel('com.example.movie_app_task/native');


  test("Get All Movies Success Case", () async {
    WidgetsFlutterBinding.ensureInitialized();
    Either<Failure, List<DiscoverMovies>> moviesList = await MoviesRepositoryImpl(moviesDataSource).getDiscoverMovies(Constants.API_KEY);
    expect(moviesList.isRight(), true);
  });

  test("Get All Movies Failure Case", () async {
    WidgetsFlutterBinding.ensureInitialized();
    Either<Failure, List<DiscoverMovies>> moviesList = await MoviesRepositoryImpl(moviesDataSource).getDiscoverMovies(Constants.API_KEY);
    expect(moviesList.isLeft(), true);
  });

  test("Get Details Movies Success Case", () async {
    WidgetsFlutterBinding.ensureInitialized();
    Either<Failure, DetailsMovieModels> movieDetails = await MoviesRepositoryImpl(moviesDataSource).getMovieDetails(movie_id, Constants.API_KEY);
    expect(movieDetails.isRight(), true);
  });

  test("Get Details Movies Failure Case", () async {
    WidgetsFlutterBinding.ensureInitialized();
    Either<Failure, DetailsMovieModels> movieDetails = await MoviesRepositoryImpl(moviesDataSource).getMovieDetails(movie_id , Constants.API_KEY);
    expect(movieDetails.isLeft(), true);
  });

}