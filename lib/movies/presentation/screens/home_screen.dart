import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app_task/core/theme/colors.dart';

import '../../data/Api/api.dart';
import '../../data/models/discover_models.dart';
import '../widgets/continue_watching_banner.dart';
import '../widgets/discover_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  late Future<List<DiscoverMovies>> discoverMovies;
  String _responseFromNativeCode = 'no data';
  static const platform=MethodChannel("com.example.movie_app_task/native");

  @override
  void initState() {
    super.initState();
    discoverMovies = Api().getDiscoverMovies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Movie App',  style: TextStyle(fontFamily: 'AABB', fontSize: 20)),
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
                      style:TextStyle(fontFamily: 'AABB',
                          fontSize: 18, color: Colours.SecondryColor),
                      children: <TextSpan>[
                    TextSpan(
                        text: ' Everywhere',
                        style: TextStyle(fontFamily: 'AABB',
                            fontSize: 18, color: Colours.WhiteColor)),
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
            // DiscoverMoviesSlider()
            SizedBox(
              child: FutureBuilder(
                future: discoverMovies,
                builder: (context,snapshot){
                  if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()));
                  }else  if(snapshot.hasData){
                    return DiscoverMoviesSlider(snapshot: snapshot);
                  }else{
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )

          ],
        ),
      ),
    );
  }

  Future<void> getData() async{
    String message;
    try{
      message = await platform.invokeMethod("getDataFromNativeCode");
    }on PlatformException catch(e){
      message = 'failed to get message ${e.message}';
    }
    setState(() {
      _responseFromNativeCode = message;
    });

  }
}


