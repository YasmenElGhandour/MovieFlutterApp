import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_task/core/helpers/constants.dart';

import '../../data/models/discover_models.dart';
import '../screens/details_screen.dart';

class DiscoverSliderItem extends StatelessWidget {
  const DiscoverSliderItem( {
    super.key,
    required this.data,
  });
  final DiscoverMovies data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsScreen(movie : data)));
      },
      child: Center(
          child: Stack(
            alignment :AlignmentDirectional.bottomCenter,
            children: [
          CachedNetworkImage(
              imageUrl: '${Constants.IMAGES_BASE_URL}${data.posterPath}',
                filterQuality: FilterQuality.high,
                height: 300.0,
                width: 300,
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.4)),
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.all(Radius.circular(15.0) //                 <--- border radius here
                      ),

                    ),
                    width: 80,
                    height: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'IMDB',
                          style: TextStyle(fontFamily: 'AABB', fontSize: 16, color: Colors.white),

                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/star.png",
                            ),
                            SizedBox(width: 4,),
                            Text(
                              '${data.voteAverage?.toStringAsFixed(2)}',
                              style: TextStyle(fontFamily: 'AABB', fontSize: 16, color: Colors.white),

                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.4)),
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.all(Radius.circular(15.0) //                 <--- border radius here
                      ),

                    ),
                    width: 250,
                    height: 50,
                    child: Center(
                      child: Text(
                        '${data.title.toString()}',
                        maxLines: 2,
                        style: TextStyle(fontFamily: 'AABB', fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center,

                      ),
                    ),
                  ),

                ],
              )
            ],
          )),
    );
  }
}
