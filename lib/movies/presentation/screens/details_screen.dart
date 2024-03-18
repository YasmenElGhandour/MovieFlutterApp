import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_task/core/theme/colors.dart';
import 'package:movie_app_task/movies/data/models/discover_models.dart';
import 'package:movie_app_task/movies/presentation/widgets/details/details_description.dart';
import 'package:movie_app_task/movies/presentation/widgets/details/details_description_title.dart';

import '../../../core/di/injectable.dart';
import '../../../core/helpers/constants.dart';
import '../../../core/helpers/enums.dart';
import '../../domain/usecases/movie_details_usecase.dart';
import '../controller/internet_bloc.dart';
import '../controller/movie_details_bloc.dart';
import '../widgets/details/details_release.dart';
import '../widgets/details/details_title.dart';
import '../widgets/details/details_watcher.dart';
import '../widgets/loading.dart';
import '../widgets/no_data.dart';
import '../widgets/no_internet.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.movie}) : super(key: key);
  final DiscoverMovies movie;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailsBloc(getIt<MovieDetailsUseCase>())
        ..add(GetMovieDetailsEvent(widget.movie!.id!.toInt()!, Constants.API_KEY)),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar.medium(
              backgroundColor: Colours.PrimaryColor,
              expandedHeight: 400,
              pinned: true,
              floating: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              flexibleSpace: FlexibleSpaceBar(
                // title: Text('${widget.movie?.title}',
                //   style: TextStyle(fontFamily: 'AABB', fontSize: 16, color: Colors.white),
                // ),
                background: CachedNetworkImage(
                  imageUrl:
                  '${Constants.IMAGES_BASE_URL}${widget.movie?.posterPath}',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colours.PrimarLightColor,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: buildDetailsBloc())
          ],
        ),
      ),
    );
  }

  Widget buildDetailsBloc() {
    return BlocConsumer<InternetBloc, InternetState>(
      listener: (BuildContext context, internetState) {
        if (internetState is ConnectedState) {
          context
              .read<MovieDetailsBloc>()
              .add(GetMovieDetailsEvent(widget.movie.id!.toInt()!, Constants.API_KEY));
        }
      },
      builder: (context, internetState) {
        return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          buildWhen: (previousState, currentState) =>
          previousState.movieDetailsState != currentState.movieDetailsState,
          builder: (BuildContext context, MovieDetailsState state) {
            switch (state.movieDetailsState) {
              case RequestState.isLoading:
                return loading();
              case RequestState.isLoaded:
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      DetailsTitle(state),
                      SizedBox(
                        height: 8,
                      ),
                      DetailsWatcher(state),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(.2),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      DetailsRelease(state),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(.2),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      DetailsDescriptionTitle(),
                      SizedBox(
                        height: 8,
                      ),
                      DetailsDescription(state: state),
                    ],
                  ),
                );

              case RequestState.isError:
                if (internetState is NotConnectedState) return NoInternet();
                return NoData('${state.movieDetailsMessage}');
            }
          },
        );
      },
    );
  }






}




