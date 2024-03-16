import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app_task/core/error/exceptions.dart';
import 'package:movie_app_task/core/helpers/constants.dart';
import 'package:movie_app_task/movies/data/data_source/movies_data_source.dart';
import 'package:movie_app_task/movies/data/models/discover_models.dart'; // Import mockito for mocking


class MockMethodChannel extends Mock implements MethodChannel {}

void main() {
  late MockMethodChannel mockChannel;
  late  MovieDataSource moviesDataSource;


}
