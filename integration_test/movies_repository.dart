
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
  MovieDataSource moviesDataSource = MovieDataSourceImpl();
  int movie_id = 763215;

  test("Get All Movies Success Case", () async {
    WidgetsFlutterBinding.ensureInitialized();
    Either<Failure, List<DiscoverMovies>> moviesList = await MoviesRepositoryImpl(moviesDataSource).getDiscoverMovies(Constants.API_KEY);
    expect(moviesList.isRight(), true);
  });

  test("Get All Movies Failure Case", () async {
    WidgetsFlutterBinding.ensureInitialized();
    Either<Failure, List<DiscoverMovies>> moviesList = await MoviesRepositoryImpl(moviesDataSource).getDiscoverMovies("ee");
    expect(moviesList.isLeft(), true);
  });

  test("Get Details Movies Success Case", () async {
    WidgetsFlutterBinding.ensureInitialized();
    Either<Failure, DetailsMovieModels> movieDetails = await MoviesRepositoryImpl(moviesDataSource).getMovieDetails(movie_id, Constants.API_KEY);
    expect(movieDetails.isRight(), true);
  });

  test("Get Details Movies Failure Case", () async {
    WidgetsFlutterBinding.ensureInitialized();
    Either<Failure, DetailsMovieModels> movieDetails = await MoviesRepositoryImpl(moviesDataSource).getMovieDetails(movie_id , "ee");
    expect(movieDetails.isLeft(), true);
  });

}