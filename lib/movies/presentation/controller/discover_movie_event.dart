import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();
}

class DiscoverMoviesEvent extends MoviesEvent {
  final String apiKey;

  const DiscoverMoviesEvent(this.apiKey);
  @override
  List<Object?> get props => [apiKey];
}
