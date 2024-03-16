import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart'; // Import mockito for mocking
import 'package:movie_app_task/core/error/exceptions.dart';
import 'package:movie_app_task/core/helpers/constants.dart';
import 'package:movie_app_task/movies/data/data_source/movies_data_source.dart';
import 'package:movie_app_task/movies/data/models/discover_models.dart';


class MockMethodChannel extends Mock implements MethodChannel {}

void main() {
  late MockMethodChannel mockChannel;
  late MovieDataSource moviesDataSource;

  setUp(() async {
    mockChannel = MockMethodChannel();
     moviesDataSource = MovieDataSourceImpl();

    // Ensure bindings for testing (Flutter 2.8+)
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  test('getDiscoverDataFromNative should return successful response from native', () async {
    const mockResponse = '{"results": [{"title": "Mock Movie"}]}';

    when(mockChannel.invokeMethod<String>("getDataFromNativeCode", any))
        .thenAnswer((_) async => mockResponse);

    final response = await moviesDataSource.getDiscoverDataFromNative(Constants.API_KEY);

    expect(response, equals(mockResponse));
  });

  test('getDiscoverDataFromNative should handle native platform exception', () async {
    final mockError = PlatformException(code: 'error_code', message: 'Error message');

    when(mockChannel.invokeMethod<String>("getDataFromNativeCode", any)).thenThrow(mockError);

    final response = await moviesDataSource.getDiscoverDataFromNative(Constants.API_KEY);

    expect(response, equals('Error : ${mockError.message}'));
  });

  test('getDiscoverMovies should return list of DiscoverMovies from successful response', () async {
    const mockResponse = '{"results": [{"title": "Mock Movie"}]}';

    when(mockChannel.invokeMethod<String>("getDataFromNativeCode", any))
        .thenAnswer((_) async => mockResponse);

    final movies = await moviesDataSource.getDiscoverMovies(Constants.API_KEY);

    expect(movies, isA<List<DiscoverMovies>>());
    expect(movies[0].title, equals('Mock Movie'));
  });

  test('getDiscoverMovies shشould throw ServerException for error response', () async {
    when(mockChannel.invokeMethod<String>("getDataFromNativeCode", any))
        .thenAnswer((_) async => 'error');

    expect(moviesDataSource.getDiscoverMovies(Constants.API_KEY),
        throwsA(isA<ServerException>()));
  });



}