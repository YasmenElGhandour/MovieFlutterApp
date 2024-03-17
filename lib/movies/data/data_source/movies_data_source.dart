
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'dart:convert';
import '../../../core/error/error_message_model.dart';
import '../../../core/error/exceptions.dart';
import '../models/details_movie_models.dart';
import '../models/discover_models.dart';

abstract class MovieDataSource {
  Future<String> getDiscoverDataFromNative(String apikey);
  Future<String> getDetailsMovieFromNative(int movieId , String apiKey);
  Future<List<DiscoverMovies>> getDiscoverMovies(String apikey);
  Future<DetailsMovieModels> getMovieDetails(int movieId,apiKey);

}

@Injectable(as: MovieDataSource)
class MovieDataSourceImpl extends MovieDataSource {

  static const platform=MethodChannel("com.example.movie_app_task/native");

  @override
  Future<String> getDiscoverDataFromNative(String apiKey) async{
    String message;
    try{
      message = await platform.invokeMethod("getDataFromNativeCode", {"apiKey":apiKey});
   //   print('response from native ${message}');
    }on PlatformException catch(e){
      message = 'Error : ${e.message}';
    }
    return message;
  }

  @override
  Future<String> getDetailsMovieFromNative(int movieId , String apiKey) async{
    String message;
    try{
      message = await platform.invokeMethod("getDetails", {"apiKey":apiKey,"movieId":movieId});
    //  print('response from native ${message}');
    }on PlatformException catch(e){
      message = 'Error : ${e.message}';
    }
    return message;
  }

  @override
  Future<List<DiscoverMovies>> getDiscoverMovies(String apiKey) async {
    final responseFromNative = await getDiscoverDataFromNative(apiKey);

    try{
      var encodedString = jsonEncode(jsonDecode(responseFromNative));
      final decodeData= json.decode(encodedString)['results'] as List;
      return decodeData.map((movie) => DiscoverMovies.fromJson(movie)).toList();
    }catch (e){
      throw ServerException(ErrorMessageModel(statusCode: 400, success: false, statusMessage: 'server error',));
    }
    // if(responseFromNative != 'error' && responseFromNative != null){
    //   var encodedString = jsonEncode(jsonDecode(responseFromNative));
    //   final decodeData= json.decode(encodedString)['results'] as List;
    //   return decodeData.map((movie) => DiscoverMovies.fromJson(movie)).toList();
    // }else{
    //   throw ServerException(ErrorMessageModel(statusCode: 400, success: false, statusMessage: 'server error',));
    // }

   //  final response = await http.get(Uri.parse('https://api.themoviedb.org/3/discover/movie?api_key=${apiKey}'));
   //  if(response.statusCode == 200){
   //    final decodeData= json.decode(response.body)['results'] as List;
   //    return decodeData.map((movie) => DiscoverMovies.fromJson(movie)).toList();
   //  }else
   //  {
   //    throw ServerException(ErrorMessageModel.fromJson(response.headers));
   //  }
  }

  @override
  Future<DetailsMovieModels> getMovieDetails(int movieId,apiKey) async {
     final responseFromNative = await getDetailsMovieFromNative(movieId , apiKey);
     try{
       var encodedString = jsonEncode(jsonDecode(responseFromNative));
       Map<String, dynamic> valueMap = jsonDecode(encodedString);
       return DetailsMovieModels.fromJson(valueMap as Map<String, dynamic>);
     }catch (e){
       throw ServerException(ErrorMessageModel(statusCode: 400, success: false, statusMessage: 'server error',));
     }
    // if(responseFromNative != 'error' && responseFromNative != null){
    //   var encodedString = jsonEncode(jsonDecode(responseFromNative));
    //   Map<String, dynamic> valueMap = jsonDecode(encodedString);
    //   return DetailsMovieModels.fromJson(valueMap as Map<String, dynamic>);
    // }else{
    //   throw ServerException(ErrorMessageModel(statusCode: 400, success: false, statusMessage: 'server error',));
    // }

    // final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/${movieId}?api_key=${apiKey}'));
    //  if(response.statusCode == 200){
    //   final decodeData= json.decode(response.body) ;
    //   return DetailsMovieModels.fromJson(decodeData as Map<String, dynamic>);
    // }else
    // {
    //   throw ServerException(ErrorMessageModel.fromJson(response));
    // }
  }


}