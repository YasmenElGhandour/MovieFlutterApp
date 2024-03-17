import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../controller/movie_details_bloc.dart';

class DetailsRelease extends StatelessWidget {
  const DetailsRelease(
    this.state, {
    super.key,
  });

  final MovieDetailsState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        popularity(),
        SizedBox(
          width: 15,
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: 1,
          height: 50,
          color: Colors.grey.withOpacity(0.2),
        ),
        SizedBox(
          width: 15,
        ),
        genre(),
      ],
    );
  }

  Expanded genre() {
    return Expanded(
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
    );
  }

  Column popularity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popularity',
          style: TextStyle(
            fontFamily: 'AABB',
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          '${state.movieDetails?.popularity}',
          style: TextStyle(
            fontFamily: 'AABB',
            fontSize: 12,
            color: Colours.GrayColor,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Release date',
          style: TextStyle(
            fontFamily: 'AABB',
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          '${state.movieDetails?.releaseDate}',
          style: TextStyle(
            fontFamily: 'AABB',
            fontSize: 12,
            color: Colours.GrayColor,
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
