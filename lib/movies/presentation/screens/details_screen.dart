
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app_task/core/theme/colors.dart';
import 'package:movie_app_task/movies/data/models/discover_models.dart';

import '../../../core/helpers/constants.dart';
import '../../data/Api/api.dart';
import '../../data/models/details_movie_models.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.movie}) : super(key: key);
final DiscoverMovies movie;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Future<DetailsMovieModels> detailsMovies;
  @override
  void initState() {
    super.initState();
    detailsMovies = Api().getDetailsMovie(widget.movie!.id!);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: [
        SliverAppBar.medium(
          backgroundColor: Colours.PrimaryColor,
          expandedHeight: 300,
          pinned: true,
          floating: true,
          leading:  IconButton(
            icon: Icon(Icons.arrow_back_ios_new , color: Colors.white,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          flexibleSpace: FlexibleSpaceBar(
            // title: Text('${widget.movie?.title}',
            //   style: TextStyle(fontFamily: 'AABB', fontSize: 16, color: Colors.white),
            // ),
            background: Image.network(
              '${Constants.IMAGES_BASE_URL}${widget.movie?.backdropPath}',
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
            ),

          ),

        ),
        SliverToBoxAdapter(
         child: Padding(
           padding: const EdgeInsets.all(16.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               SizedBox(height: 8,),
               Text('${widget.movie?.title}',style: TextStyle(fontFamily: 'AABB', fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
               SizedBox(height: 8,),
               Row(
                 children: [
                   Icon(Icons.confirmation_num_sharp , color: Colours.GrayColor,size: 15,),
                   SizedBox(width: 4,),
                   Text('${widget.movie?.voteCount} Count',style: TextStyle(fontFamily: 'AABB', fontSize: 12, color: Colours.GrayColor)),
                   SizedBox(width: 20,),
                   Icon(Icons.star , color: Colours.GrayColor,size: 15,),
                   SizedBox(width: 4,),
                   Text('${widget.movie?.voteAverage?.toStringAsFixed(2)} (IMDP)',style: TextStyle(fontFamily: 'AABB', fontSize: 12, color: Colours.GrayColor)),

                 ],
               ),
               SizedBox(height: 8,),
               Divider(color: Colors.grey.withOpacity(.2),),
               SizedBox(height: 8,),
               Row(
                 children: [
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text('Release date',style: TextStyle(fontFamily: 'AABB', fontSize: 14, color: Colors.white)),
                       SizedBox(height: 8,),
                       Text('${widget.movie?.releaseDate}',style: TextStyle(fontFamily: 'AABB', fontSize: 12, color: Colours.GrayColor)),
                     ],
                   ),
                   SizedBox(width: 30,),

                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text('Popularity',style: TextStyle(fontFamily: 'AABB', fontSize: 14, color: Colors.white)),
                       SizedBox(height: 8,),
                       Text('${widget.movie?.popularity}',style: TextStyle(fontFamily: 'AABB', fontSize: 12, color: Colours.GrayColor)),
                     ],
                   )

                 ],
               ),
               SizedBox(height: 8,),
               Divider(color: Colors.grey.withOpacity(.2),),
               SizedBox(height: 8,),
               Text('Description',style: TextStyle(fontFamily: 'AABB', fontSize: 15, color: Colors.white)),
               SizedBox(height: 8,),
               Text('${widget.movie?.overview}',style: TextStyle(fontFamily: 'AABB', fontSize: 14, color: Colours.GrayColor,)),

             ],
           ),
         ),
       )

        ],
      ),

    );
  }
}
