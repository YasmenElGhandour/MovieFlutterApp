import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_task/core/theme/colors.dart';

import '../../../core/di/injectable.dart';
import '../../../core/helpers/enums.dart';
import '../../data/Api/api.dart';
import '../../data/models/discover_models.dart';
import '../../domain/usecases/discover_movie_usecase.dart';
import '../controller/discover_movie_bloc.dart';
import '../controller/discover_movie_event.dart';
import '../controller/discover_movie_state.dart';
import '../widgets/continue_watching_banner.dart';
import '../widgets/discover_slider.dart';
import '../../../core/helpers/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<DiscoverMovies>> discoverMovies;
  String _responseFromNativeCode = 'no data';
  static const platform = MethodChannel("com.example.movie_app_task/native");

  @override
  void initState() {
    super.initState();
    discoverMovies = Api().getDiscoverMovies();
  }

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

  Future<void> getData() async {
    String message;
    try {
      message = await platform.invokeMethod("getDataFromNativeCode");
    } on PlatformException catch (e) {
      message = 'failed to get message ${e.message}';
    }
    setState(() {
      _responseFromNativeCode = message;
    });
  }

  buildCarouselBloc() {
    return  BlocBuilder<MoviesBloc , MoviesState>(
      buildWhen: (previousState, currentState) =>
      previousState.discoverRequestState != currentState.discoverRequestState,
      builder: (BuildContext context, MoviesState state) {
        switch (state.discoverRequestState) {
          case RequestState.isLoading:
            return const SizedBox(
              height: 200,
              child: Center(
                child: CircularProgressIndicator(color: Colours.SecondryColor,),
              ),
            );
          case RequestState.isLoaded:
            if(state.discoverMovies?.length != 0)
            return DiscoverMoviesSlider(moviesList: state.discoverMovies!);
            else  return SizedBox(
              height: 400,
              child: Text(
                'No Data',
              )
            );
          case RequestState.isError:
            return SizedBox(
              height: 400,
              child: Text(
                state.discoverMessage,
              ),
            );
        }
      },

    );

  }
}
