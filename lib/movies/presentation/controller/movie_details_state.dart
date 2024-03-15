part of 'movie_details_bloc.dart';

class MovieDetailsState extends Equatable {
  final DetailsMovieModels? movieDetails;
  final RequestState movieDetailsState;
  final String movieDetailsMessage;


  const MovieDetailsState({
    this.movieDetails,
    this.movieDetailsState = RequestState.isLoading,
    this.movieDetailsMessage = '',
  });

  MovieDetailsState copyWith({
    DetailsMovieModels? movieDetails,
    RequestState? movieDetailsState,
    String? movieDetailsMessage,
  }) {
    return MovieDetailsState(
      movieDetails: movieDetails ?? this.movieDetails,
      movieDetailsState: movieDetailsState ?? this.movieDetailsState,
      movieDetailsMessage: movieDetailsMessage ?? this.movieDetailsMessage,
    );
  }

  @override
  List<Object?> get props => [
    movieDetailsState,
    movieDetails,
    movieDetailsMessage,
  ];
}