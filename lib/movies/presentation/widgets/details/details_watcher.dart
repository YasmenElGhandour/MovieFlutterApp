import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../controller/movie_details_bloc.dart';

class DetailsWatcher extends StatelessWidget {
  const DetailsWatcher(this.state, {
    super.key,
  });
  final MovieDetailsState state;

  @override
  Widget build(BuildContext context) {
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
}
