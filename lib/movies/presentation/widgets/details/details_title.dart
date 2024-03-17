
import 'package:flutter/material.dart';

import '../../controller/movie_details_bloc.dart';


class DetailsTitle extends StatelessWidget {
   DetailsTitle(this.state,  {
    super.key,
  });
  final MovieDetailsState state;

  @override
  Widget build(BuildContext context) {
    return Text('${state.movieDetails?.title}',
        style: TextStyle(
            fontFamily: 'AABB',
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold));
  }
}