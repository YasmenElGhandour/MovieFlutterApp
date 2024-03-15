import 'package:equatable/equatable.dart';

import '../../../core/helpers/enums.dart';
import '../../data/models/discover_models.dart';


class MoviesState extends Equatable {
  final List<DiscoverMovies>? discoverMovies;
  final RequestState discoverRequestState;
  final String discoverMessage;

  const MoviesState({
     this.discoverMovies,
    this.discoverRequestState = RequestState.isLoading,
    this.discoverMessage = '',

  });

  MoviesState  copyWith({
    List<DiscoverMovies>? discoverMovies,
    RequestState? discoverRequestState,
    String? discoverMessage,
  }) {
    return MoviesState(
      discoverMovies: discoverMovies ?? this.discoverMovies,
      discoverRequestState: discoverRequestState ?? this.discoverRequestState,
      discoverMessage: discoverMessage ?? this.discoverMessage,
    );
  }

  @override
  List<Object?> get props => [
    discoverMovies,
    discoverRequestState,
    discoverMessage
  ];
}