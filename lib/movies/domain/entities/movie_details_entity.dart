import 'package:equatable/equatable.dart';

import 'genres_entity.dart';


class MovieDetails extends Equatable {
  final List<Genres> genres;
  final int id;
  final String backdropPath;
  final String overview;
  final String releaseDate;
  final int runTime;
  final String title;
  final double voteAverage;

  const MovieDetails(
      {required this.id,
        required this.backdropPath,
        required this.overview,
        required this.releaseDate,
        required this.runTime,
        required this.title,
        required this.voteAverage,
        required this.genres});

  @override
  List<Object?> get props => [
    id,
    backdropPath,
    overview,
    releaseDate,
    runTime,
    title,
    voteAverage,
    genres
  ];
}