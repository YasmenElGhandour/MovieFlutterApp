import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/helpers/enums.dart';
import '../../domain/usecases/discover_movie_usecase.dart';
import 'discover_movie_event.dart';
import 'discover_movie_state.dart';

@Injectable()
class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final DiscoverMoviesUseCase discoverMoviesUseCase;

  MoviesBloc(this.discoverMoviesUseCase) : super(const MoviesState()) {
    on<DiscoverMoviesEvent>(_getDiscoverMovies);
  }

  void _getDiscoverMovies(DiscoverMoviesEvent moviesEvent, Emitter emit) async {
    print("_getDiscoverMovies");
    try {
      final result = await discoverMoviesUseCase(
          MovieParameters(apiKey: moviesEvent.apiKey));
      print("result");
      print(result);
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
    } catch (e) {
      emit(state.copyWith(
        discoverRequestState: RequestState.isError,
        discoverMessage: "Something Went Wrong",
      ));
    }
    // on PlatformException catch (e) {
    //   print(e.details);
    //   // emit(state.copyWith(
    //   //   discoverRequestState: RequestState.isError,
    //   //   discoverMessage: e.toString(),
    //   // ));
    //   ;
    // }
  }
}
