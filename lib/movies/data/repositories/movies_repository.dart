
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';
import '../../domain/repositries/movies_repository.dart';
import '../data_source/movies_data_source.dart';
import '../models/details_movie_models.dart';
import '../models/discover_models.dart';

@Injectable(as: MoviesRepository)
class MoviesRepositoryImpl extends MoviesRepository {
  final MovieDataSource moviesDataSource;
  MoviesRepositoryImpl(this.moviesDataSource);

  @override
  Future<Either<Failure, List<DiscoverMovies>>> getDiscoverMovies(String apiKey) async {
    try {
      final result = await moviesDataSource.getDiscoverMovies(apiKey);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }


  @override
  Future<Either<Failure, DetailsMovieModels>> getMovieDetails(int movieId,String apikey) async {
    try {
      final result =
      await moviesDataSource.getMovieDetails(movieId,apikey);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }


}