
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../core/error/error_message_model.dart';
import '../../../core/error/exceptions.dart';
import '../models/details_movie_models.dart';
import '../models/discover_models.dart';

abstract class MovieDataSource {
  Future<List<DiscoverMovies>> getDiscoverMovies(String apikey);
  Future<DetailsMovieModels> getMovieDetails(int movieId,apiKey);

}

class MovieDataSourceImpl extends MovieDataSource {
  @override
  Future<List<DiscoverMovies>> getDiscoverMovies(String apiKey)async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/discover/movie?api_key=${apiKey}'));
    if(response.statusCode == 200){
      final decodeData= json.decode(response.body)['results'] as List;
      return decodeData.map((movie) => DiscoverMovies.fromJson(movie)).toList();
    }else
    {
      throw ServerException(ErrorMessageModel.fromJson(response.headers));
    }
  }

  @override
  Future<DetailsMovieModels> getMovieDetails(int movieId,apiKey) async {

    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/${movieId}?api_key=${apiKey}'));
    if(response.statusCode == 200){
      final decodeData= json.decode(response.body) ;
      return DetailsMovieModels.fromJson(decodeData as Map<String, dynamic>);
    }else
    {
      throw ServerException(ErrorMessageModel.fromJson(response.headers));
    }
  }


}