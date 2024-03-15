part of 'movie_details_bloc.dart';

abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();
}

class GetMovieDetailsEvent extends MovieDetailsEvent {
  final int id;
  final String apiKey;

  const GetMovieDetailsEvent(this.id,this.apiKey);
  @override
  List<Object?> get props => [id,apiKey];
}
