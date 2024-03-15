
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../core/helpers/enums.dart';
import '../../domain/usecases/discover_movie_usecase.dart';
import 'discover_movie_event.dart';
import 'discover_movie_state.dart';

@Injectable()
class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final DiscoverMoviesUseCase discoverMoviesUseCase;

  MoviesBloc(this.discoverMoviesUseCase)
      : super(const MoviesState()) {
    on<DiscoverMoviesEvent>(_getDiscoverMovies);
  }

  void _getDiscoverMovies(DiscoverMoviesEvent moviesEvent, Emitter emit) async {
    final result = await discoverMoviesUseCase(MovieParameters(apiKey: moviesEvent.apiKey));
      result.fold(
            (l) => emit(state.copyWith(
          discoverRequestState: RequestState.isError,
          discoverMessage: l.message,
        )),
            (r) => emit(state.copyWith(
          discoverMovies: r,
          discoverRequestState: RequestState.isLoaded,
        )),
      );

  }



}