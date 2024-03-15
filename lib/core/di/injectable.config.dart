// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:movie_app_task/movies/data/data_source/movies_data_source.dart'
    as _i3;
import 'package:movie_app_task/movies/data/repositories/movies_repository.dart'
    as _i5;
import 'package:movie_app_task/movies/domain/repositries/movies_repository.dart'
    as _i4;
import 'package:movie_app_task/movies/domain/usecases/discover_movie_usecase.dart'
    as _i6;
import 'package:movie_app_task/movies/domain/usecases/movie_details_usecase.dart'
    as _i7;
import 'package:movie_app_task/movies/presentation/controller/discover_movie_bloc.dart'
    as _i8;
import 'package:movie_app_task/movies/presentation/controller/movie_details_bloc.dart'
    as _i9;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.MovieDataSource>(() => _i3.MovieDataSourceImpl());
    gh.factory<_i4.MoviesRepository>(
        () => _i5.MoviesRepositoryImpl(gh<_i3.MovieDataSource>()));
    gh.factory<_i6.DiscoverMoviesUseCase>(
        () => _i6.DiscoverMoviesUseCase(gh<_i4.MoviesRepository>()));
    gh.factory<_i7.MovieDetailsUseCase>(
        () => _i7.MovieDetailsUseCase(gh<_i4.MoviesRepository>()));
    gh.factory<_i8.MoviesBloc>(
        () => _i8.MoviesBloc(gh<_i6.DiscoverMoviesUseCase>()));
    gh.factory<_i9.MovieDetailsBloc>(
        () => _i9.MovieDetailsBloc(gh<_i7.MovieDetailsUseCase>()));
    return this;
  }
}
