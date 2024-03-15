
import '../models/details_movie_models.dart';
import '../models/discover_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api{

  Future<List<DiscoverMovies>> getDiscoverMovies() async{
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/discover/movie?api_key=c4c77dec8838783e8651d15e92df4606'));
    if(response.statusCode == 200){
      final decodeData= json.decode(response.body)['results'] as List;
      return decodeData.map((movie) => DiscoverMovies.fromJson(movie)).toList();
    }else
      {
        throw Exception('Some thing wrong');
      }

  }

  Future<DetailsMovieModels> getDetailsMovie(int movieId) async{
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/${movieId}?api_key=c4c77dec8838783e8651d15e92df4606'));
    if(response.statusCode == 200){
       final decodeData= json.decode(response.body) ;
       return DetailsMovieModels.fromJson(decodeData as Map<String, dynamic>);

    }else
    {
      throw Exception('Some thing wrong');
    }

  }

}