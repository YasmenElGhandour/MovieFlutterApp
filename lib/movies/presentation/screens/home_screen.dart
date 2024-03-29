import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_task/core/theme/colors.dart';
import 'package:movie_app_task/movies/presentation/widgets/no_internet.dart';

import '../../../core/di/injectable.dart';
import '../../../core/helpers/constants.dart';
import '../../../core/helpers/enums.dart';
import '../../domain/usecases/discover_movie_usecase.dart';
import '../controller/discover_movie_bloc.dart';
import '../controller/discover_movie_event.dart';
import '../controller/discover_movie_state.dart';
import '../controller/internet_bloc.dart';
import '../widgets/home/continue_watching_banner.dart';
import '../widgets/home/discover_slider.dart';
import '../widgets/loading.dart';
import '../widgets/no_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MoviesBloc(getIt<DiscoverMoviesUseCase>())
          ..add(DiscoverMoviesEvent(Constants.API_KEY)),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Movie App',
                style: TextStyle(fontFamily: 'AABB', fontSize: 20)),
            centerTitle: true,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                      text: TextSpan(
                          text: 'Stream',
                          style: TextStyle(
                              fontFamily: 'AABB',
                              fontSize: 18,
                              color: Colours.SecondryColor),
                          children: <TextSpan>[
                        TextSpan(
                            text: ' Everywhere',
                            style: TextStyle(
                                fontFamily: 'AABB',
                                fontSize: 18,
                                color: Colours.WhiteColor)),
                      ])),
                ),
                SizedBox(
                  height: 8,
                ),
                ContinueWatchingBanner(),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Discover Movies',
                    style: TextStyle(fontFamily: 'AABB', fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                buildCarouselBloc()

                // SizedBox(
                //   child: FutureBuilder(
                //     future: discoverMovies,
                //     builder: (context, snapshot) {
                //       if (snapshot.hasError) {
                //         return Center(child: Text(snapshot.error.toString()));
                //       } else if (snapshot.hasData) {
                //         return DiscoverMoviesSlider(snapshot: snapshot);
                //       } else {
                //         return Center(child: CircularProgressIndicator());
                //       }
                //     },
                //   ),
                // )
              ],
            ),
          ),
        ));
  }

  buildCarouselBloc() {
    return BlocConsumer<InternetBloc, InternetState>(
      listener: (BuildContext context, internetState) {
        if (internetState is ConnectedState) {
          context
              .read<MoviesBloc>()
              .add(DiscoverMoviesEvent(Constants.API_KEY));
        }
      },
      builder: (context, internetState) {
        return BlocBuilder<MoviesBloc, MoviesState>(
          buildWhen: (previousState, currentState) =>
              previousState.discoverRequestState !=
              currentState.discoverRequestState,
          builder: (BuildContext context, MoviesState state) {
            var data = state.discoverMovies;
            switch (state.discoverRequestState) {
              case RequestState.isLoading:
                return loading();
              case RequestState.isLoaded:
                if (state.discoverMovies?.length != 0)
                  return DiscoverMoviesSlider(
                      moviesList: state.discoverMovies!);
                else
                  return NoData('No data');
              case RequestState.isError:
                if (internetState is NotConnectedState) return NoInternet();
                return NoData('${state.discoverMessage}');
            }
          },
        );
      },
    );
  }


}
