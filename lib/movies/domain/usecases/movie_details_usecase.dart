
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failure.dart';
import '../../../core/use_case/base_use_case.dart';
import '../../data/models/details_movie_models.dart';
import '../repositries/movies_repository.dart';

@Injectable()
class MovieDetailsUseCase extends BaseUseCase<DetailsMovieModels,MovieDetailsParameters> {
  final MoviesRepository moviesRepository;
  MovieDetailsUseCase(this.moviesRepository);
  @override
  Future<Either<Failure, DetailsMovieModels>> call(MovieDetailsParameters parameters) async {
    return moviesRepository.getMovieDetails(parameters.movieId ,parameters.apiKey);
  }
}

class MovieDetailsParameters extends Equatable {
  final int movieId;
  final String apiKey;
  const MovieDetailsParameters({required this.movieId,required this.apiKey});
  @override
  List<Object?> get props => [movieId,apiKey];
}