import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_task/core/theme/colors.dart';
import 'package:movie_app_task/movies/data/models/discover_models.dart';
import 'package:movie_app_task/movies/presentation/widgets/home/discover_slider_item.dart';


class DiscoverMoviesSlider extends StatelessWidget {
  const DiscoverMoviesSlider({
    super.key, required this.moviesList,
  });

 // final AsyncSnapshot snapshot;
   final List<DiscoverMovies> moviesList;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
          itemCount: 10,
          itemBuilder: (context, itemIndex, pageViewIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 300,
                height: 300,
                color: Colours.PrimaryColor,
                child: DiscoverSliderItem(data: moviesList[itemIndex],),
              ),
            );
          },
          options: CarouselOptions(
              height: 300,
              autoPlay: true,
              autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
              autoPlayAnimationDuration: Duration(seconds: 2),
              enlargeCenterPage: true,
              viewportFraction: 0.7)),
    );
  }
}

