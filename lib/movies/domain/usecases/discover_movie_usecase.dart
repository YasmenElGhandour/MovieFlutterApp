
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failure.dart';
import '../../../core/use_case/base_use_case.dart';
import '../../data/models/discover_models.dart';
import '../repositries/movies_repository.dart';

@Injectable()
class DiscoverMoviesUseCase extends BaseUseCase<List<DiscoverMovies>,MovieParameters> {
  final MoviesRepository moviesRepository;
  DiscoverMoviesUseCase(this.moviesRepository);
  @override
  Future<Either<Failure, List<DiscoverMovies>>> call(MovieParameters parameters) async {
    return moviesRepository.getDiscoverMovies(parameters.apiKey);
  }
}

class MovieParameters extends Equatable {
  final String apiKey;
  const MovieParameters({required this.apiKey});
  @override
  List<Object?> get props => [apiKey];
}