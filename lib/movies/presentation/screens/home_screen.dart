import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_task/core/theme/colors.dart';

import '../../../core/di/injectable.dart';
import '../../../core/helpers/enums.dart';
import '../../domain/usecases/discover_movie_usecase.dart';
import '../controller/discover_movie_bloc.dart';
import '../controller/discover_movie_event.dart';
import '../controller/discover_movie_state.dart';
import '../widgets/continue_watching_banner.dart';
import '../widgets/discover_slider.dart';
import '../../../core/helpers/constants.dart';
import '../widgets/loading.dart';
import '../widgets/no_data.dart';
import '../widgets/no_internet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MoviesBloc(getIt<DiscoverMoviesUseCase>())..add(DiscoverMoviesEvent(Constants.API_KEY)),
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
    return  BlocBuilder<MoviesBloc , MoviesState>(
      buildWhen: (previousState, currentState) =>
      previousState.discoverRequestState != currentState.discoverRequestState,
      builder: (BuildContext context, MoviesState state) {
        var data = state.discoverMovies;
        switch (state.discoverRequestState) {
          case RequestState.isLoading:
            //no cached data && no internet
          if(_connectionStatus == ConnectivityResult.none){
            return  data == null ? NoInternet() : SizedBox();
          } else  return loading();
          case RequestState.isLoaded:
            if(state.discoverMovies?.length != 0)
            return DiscoverMoviesSlider(moviesList: state.discoverMovies!);
            else  return NoData('No data');
          case RequestState.isError:
            return  NoData('${state.discoverMessage}');

        }
      },

    );

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




