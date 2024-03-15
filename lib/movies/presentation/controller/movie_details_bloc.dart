
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/enums.dart';
import '../../data/models/details_movie_models.dart';
import '../../domain/usecases/movie_details_usecase.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MovieDetailsUseCase movieDetailsUseCase;
  MovieDetailsBloc(this.movieDetailsUseCase) : super(const MovieDetailsState()) {
    on<GetMovieDetailsEvent>(_getMovieDetailsEvent);
  }

  void _getMovieDetailsEvent(GetMovieDetailsEvent event, Emitter emit) async {
    final result = await movieDetailsUseCase(MovieDetailsParameters(movieId: event.id, apiKey: event.apiKey));
    result.fold(
          (l) => emit(
        state.copyWith(
          movieDetailsState: RequestState.isError,
          movieDetailsMessage: l.message,
        ),
      ),
          (r) => emit(
        state.copyWith(
          movieDetails: r,
          movieDetailsState: RequestState.isLoaded,
        ),
      ),
    );
  }


}