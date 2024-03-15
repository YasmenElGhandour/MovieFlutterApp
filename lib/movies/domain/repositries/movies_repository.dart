
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../data/models/details_movie_models.dart';
import '../../data/models/discover_models.dart';


abstract class MoviesRepository {
  Future<Either<Failure, List<DiscoverMovies>>> getDiscoverMovies(String apiKey);
  Future<Either<Failure, DetailsMovieModels>> getMovieDetails(int movieId,String apiKey);
}