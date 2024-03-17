import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../controller/movie_details_bloc.dart';

class DetailsDescription extends StatelessWidget {
  const DetailsDescription({
    super.key,
    required this.state,
  });

  final MovieDetailsState state;

  @override
  Widget build(BuildContext context) {
    return Text('${state.movieDetails?.overview}',
        style: TextStyle(
          fontFamily: 'AABB',
          fontSize: 14,
          color: Colours.GrayColor,
        ));
  }
}