import 'package:equatable/equatable.dart';

import '../../../core/helpers/enums.dart';
import '../../data/models/discover_models.dart';


class MoviesState extends Equatable {
  final List<DiscoverMovies> discoverMovies;
  final RequestState discoverRequestState;
  final String discoverMessage;

  const MoviesState({
    this.discoverMovies = const [],
    this.discoverRequestState = RequestState.isLoading,
    this.discoverMessage = "",

  });

  copyWith({
    List<DiscoverMovies>? discoverMovies,
    RequestState? discoverRequestState,
    String? discoverMessage,
  }) {
    return MoviesState(
      discoverMovies: discoverMovies ?? this.discoverMovies,
      discoverMessage: discoverMessage ?? this.discoverMessage,
    );
  }

  @override
  List<Object?> get props => [
    discoverMovies,
  ];
}