import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_app_task/core/theme/colors.dart';
import 'package:movie_app_task/movies/data/models/discover_models.dart';

import '../../../core/di/injectable.dart';
import '../../../core/helpers/constants.dart';
import '../../../core/helpers/enums.dart';
import '../../data/models/details_movie_models.dart';
import '../../domain/usecases/movie_details_usecase.dart';
import '../controller/movie_details_bloc.dart';
import '../widgets/loading.dart';
import '../widgets/no_internet.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.movie}) : super(key: key);
  final DiscoverMovies movie;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailsBloc(getIt<MovieDetailsUseCase>())
        ..add(GetMovieDetailsEvent(widget.movie!.id!, Constants.API_KEY)),
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
                  imageUrl: '${Constants.IMAGES_BASE_URL}${widget.movie?.posterPath}',
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

  BlocBuilder<MovieDetailsBloc, MovieDetailsState> buildDetailsBloc() {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      buildWhen: (previousState, currentState) =>
          previousState.movieDetailsState != currentState.movieDetailsState,
      builder: (BuildContext context, MovieDetailsState state) {
        switch (state.movieDetailsState) {
          case RequestState.isLoading:
            if (_connectionStatus == ConnectivityResult.none) {
              return state.movieDetails != null ? SizedBox(): NoInternet();
            } else
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
                  buildTitle(state),
                  SizedBox(
                    height: 8,
                  ),
                  buildWatchersRow(state),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(.2),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  buildRelaseRow(state),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(.2),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  buildDescriptionTitle(),
                  SizedBox(
                    height: 8,
                  ),
                  buildDescription(state),
                ],
              ),
            );
          case RequestState.isError:
            return SizedBox(
              height: 400,
              child: Text(
                state.movieDetailsMessage,
              ),
            );
        }
      },
    );
  }

  Text buildDescription(MovieDetailsState state) {
    return Text('${state.movieDetails?.overview}',
        style: TextStyle(
          fontFamily: 'AABB',
          fontSize: 14,
          color: Colours.GrayColor,
        ));
  }

  Text buildDescriptionTitle() {
    return Text('Description',
        style: TextStyle(fontFamily: 'AABB', fontSize: 15, color: Colors.white));
  }

  Row buildRelaseRow(MovieDetailsState state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Release date',
                style: TextStyle(
                    fontFamily: 'AABB', fontSize: 14, color: Colors.white)),
            SizedBox(
              height: 8,
            ),
            Text('${state.movieDetails?.releaseDate}',
                style: TextStyle(
                    fontFamily: 'AABB',
                    fontSize: 12,
                    color: Colours.GrayColor)),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Popularity',
                style: TextStyle(
                    fontFamily: 'AABB', fontSize: 14, color: Colors.white)),
            SizedBox(
              height: 8,
            ),
            Text('${state.movieDetails?.popularity}',
                style: TextStyle(
                    fontFamily: 'AABB',
                    fontSize: 12,
                    color: Colours.GrayColor)),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Genre',
                  style: TextStyle(
                      fontFamily: 'AABB', fontSize: 14, color: Colors.white)),
              SizedBox(
                height: 8,
              ),
              Wrap(
                children: state.movieDetails!.genres!
                    .map((e) => Container(
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(.2)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: new Text(e.name.toString() + ' ',
                                style: TextStyle(
                                    fontFamily: 'AABB',
                                    fontSize: 12,
                                    color: Colors.white)),
                          ),
                        ))
                    .toList(),
              )
            ],
          ),
        ),
      ],
    );
  }

  Row buildWatchersRow(MovieDetailsState state) {
    return Row(
      children: [
        Icon(
          Icons.confirmation_num_sharp,
          color: Colours.GrayColor,
          size: 15,
        ),
        SizedBox(
          width: 4,
        ),
        Text('${state.movieDetails?.voteCount} Count',
            style: TextStyle(
                fontFamily: 'AABB', fontSize: 12, color: Colours.GrayColor)),
        SizedBox(
          width: 20,
        ),
        Icon(
          Icons.star,
          color: Colours.GrayColor,
          size: 15,
        ),
        SizedBox(
          width: 4,
        ),
        Text('${state.movieDetails?.voteAverage?.toStringAsFixed(2)} (IMDP)',
            style: TextStyle(
                fontFamily: 'AABB', fontSize: 12, color: Colours.GrayColor)),
      ],
    );
  }

  Text buildTitle(MovieDetailsState state) {
    return Text('${state.movieDetails?.title}',
        style: TextStyle(
            fontFamily: 'AABB',
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold));
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }


  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      // developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

}
