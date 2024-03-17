
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_task/core/di/injectable.dart';
import 'package:movie_app_task/core/error/exceptions.dart';
import 'package:movie_app_task/core/helpers/constants.dart';
import 'package:movie_app_task/movies/data/data_source/movies_data_source.dart';
import 'package:movie_app_task/movies/data/models/details_movie_models.dart';
import 'package:movie_app_task/movies/data/models/discover_models.dart';

import 'dummy_data.dart';

void main() {

  setUpAll(() => {configureDependencies()});

  //discover movies from native ......
  test('getDiscoverDataFromNative should not be empty', () async {
    final response = await MovieDataSourceImpl().getDiscoverDataFromNative(Constants.API_KEY);
    expect(response.isNotEmpty, true);
  });

   test('discover movies list from native return successful response', () async {
  final mockResponse='{"page":1,"results":[{"adult":false,"backdrop_path":"/deLWkOLZmBNkm8p16igfapQyqeq.jpg","genre_ids":[14,12,28],"id":763215,"original_language":"en","original_title":"Damsel","overview":"A young woman\\u0027s marriage to a charming prince turns into a fierce fight for survival when she\\u0027s offered up as a sacrifice to a fire-breathing dragon.","popularity":2754.204,"poster_path":"/sMp34cNKjIb18UBOCoAv4DpCxwY.jpg","release_date":"2024-03-08","title":"Damsel","video":false,"vote_average":7.294,"vote_count":757},{"adult":false,"backdrop_path":"/gJL5kp5FMopB2sN4WZYnNT5uO0u.jpg","genre_ids":[28,12,16,35,10751],"id":1011985,"original_language":"en","original_title":"Kung Fu Panda 4","overview":"Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.","popularity":2701.294,"poster_path":"/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg","release_date":"2024-03-02","title":"Kung Fu Panda 4","video":false,"vote_average":6.9,"vote_count":132},{"adult":false,"backdrop_path":"/xvk5AhfhgQcTuaCQyq3XqAnhEma.jpg","genre_ids":[28,12,35],"id":848538,"original_language":"en","original_title":"Argylle","overview":"When the plots of reclusive author Elly Conway\\u0027s fictional espionage novels begin to mirror the covert actions of a real-life spy organization, quiet evenings at home become a thing of the past. Accompanied by her cat Alfie and Aiden, a cat-allergic spy, Elly races across the world to stay one step ahead of the killers as the line between Conway\\u0027s fictional world and her real one begins to blur.","popularity":1548.478,"poster_path":"/95VlSEfLMqeX36UVcHJuNlWEpwf.jpg","release_date":"2024-01-31","title":"Argylle","video":false,"vote_average":6.11,"vote_count":573},{"adult":false,"backdrop_path":"/cu5Qk2QHxOyyMrD3Bq93DxgmJer.jpg","genre_ids":[28,80],"id":1046090,"original_language":"zh","original_title":"周處除三害","overview":"The arrogant, third most-wanted criminal in Taiwan, decides to get rid of the top two competitors and crowns himself the most-wanted criminal before dying.","popularity":1348.086,"poster_path":"/7IJ7F8tX7IAkpUdaGovOBJqORnJ.jpg","release_date":"2023-10-06","title":"The Pig, the Snake and the Pigeon","video":false,"vote_average":7.6,"vote_count":82},{"adult":false,"backdrop_path":"/mDeUmPe4MF35WWlAqj4QFX5UauJ.jpg","genre_ids":[28,27,53],"id":1096197,"original_language":"pt","original_title":"No Way Up","overview":"Characters from different backgrounds are thrown together when the plane they\\u0027re travelling on crashes into the Pacific Ocean. A nightmare fight for survival ensues with the air supply running out and dangers creeping in from all sides.","popularity":1389.893,"poster_path":"/hu40Uxp9WtpL34jv3zyWLb5zEVY.jpg","release_date":"2024-01-18","title":"No Way Up","video":false,"vote_average":6.069,"vote_count":231},{"adult":false,"backdrop_path":"/o6e8Y0Q7RZIWi4qcJq4s5OYOVJs.jpg","genre_ids":[878,10749,35],"id":792307,"original_language":"en","original_title":"Poor Things","overview":"Brought back to life by an unorthodox scientist, a young woman runs off with a debauched lawyer on a whirlwind adventure across the continents. Free from the prejudices of her times, she grows steadfast in her purpose to stand for equality and liberation.","popularity":1059.216,"poster_path":"/kCGlIMHnOm8JPXq3rXM6c5wMxcT.jpg","release_date":"2023-12-07","title":"Poor Things","video":false,"vote_average":7.888,"vote_count":2320},{"adult":false,"backdrop_path":"/47olX0FCvUCfAqlp8cK0O5fKLav.jpg","genre_ids":[16,35,878],"id":1239251,"original_language":"en","original_title":"Megamind vs. the Doom Syndicate","overview":"Megamind\\u0027s former villain team, The Doom Syndicate, has returned. Our newly crowned blue hero must now keep up evil appearances until he can assemble his friends (Roxanne, Ol\\u0027 Chum and Keiko) to stop his former evil teammates from launching Metro City to the Moon.","popularity":1127.103,"poster_path":"/yRZfiG1QpRkBc7fAmxfcR7Md5EC.jpg","release_date":"2024-03-01","title":"Megamind vs. the Doom Syndicate","video":false,"vote_average":5.667,"vote_count":117},{"adult":false,"backdrop_path":"/8uVKfOJUhmybNsVh089EqLHUYEG.jpg","genre_ids":[878,12],"id":693134,"original_language":"en","original_title":"Dune: Part Two","overview":"Follow the mythic journey of Paul Atreides as he unites with Chani and the Fremen while on a path of revenge against the conspirators who destroyed his family. Facing a choice between the love of his life and the fate of the known universe, Paul endeavors to prevent a terrible future only he can foresee.","popularity":1054.137,"poster_path":"/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg","release_date":"2024-02-27","title":"Dune: Part Two","video":false,"vote_average":8.414,"vote_count":1699},{"adult":false,"backdrop_path":"/ekRp1sEA8pnuzVHQkUESTgNSKdW.jpg","genre_ids":[878,28,80],"id":932420,"original_language":"en","original_title":"Code 8 Part II","overview":"In a world where superpowered people are heavily policed by robots, an ex-con teams up with a drug lord he despises to protect a teen from a corrupt cop.","popularity":960.754,"poster_path":"/hhvMTxlTZtnCOe7YFhod9uz3m37.jpg","release_date":"2024-02-27","title":"Code 8 Part II","video":false,"vote_average":6.597,"vote_count":283},{"adult":false,"backdrop_path":"/oFAukXiMPrwLpbulGmB5suEZlrm.jpg","genre_ids":[28,12,878,14,18],"id":624091,"original_language":"id","original_title":"Sri Asih","overview":"Alana discover the truth about her origin: she’s not an ordinary human being. She may be the gift for humanity and become its protector as Sri Asih. Or a destruction, if she can’t control her anger.","popularity":1217.203,"poster_path":"/wShcJSKMFg1Dy1yq7kEZuay6pLS.jpg","release_date":"2022-11-17","title":"Sri Asih","video":false,"vote_average":6.327,"vote_count":26},{"adult":false,"backdrop_path":"/oBIQDKcqNxKckjugtmzpIIOgoc4.jpg","genre_ids":[28,53,10752],"id":969492,"original_language":"en","original_title":"Land of Bad","overview":"When a Delta Force special ops mission goes terribly wrong, Air Force drone pilot Reaper has 48 hours to remedy what has devolved into a wild rescue operation. With no weapons and no communication other than the drone above, the ground mission suddenly becomes a full-scale battle when the team is discovered by the enemy.","popularity":855.698,"poster_path":"/lYwjlcBjokC9EhfzfAOkTMQd5Ku.jpg","release_date":"2024-01-25","title":"Land of Bad","video":false,"vote_average":6.968,"vote_count":341},{"adult":false,"backdrop_path":"/meyhnvssZOPPjud4F1CjOb4snET.jpg","genre_ids":[16,28,12,35,10751],"id":940551,"original_language":"en","original_title":"Migration","overview":"After a migrating duck family alights on their pond with thrilling tales of far-flung places, the Mallard family embarks on a family road trip, from New England, to New York City, to tropical Jamaica.","popularity":805.294,"poster_path":"/ldfCF9RhR40mppkzmftxapaHeTo.jpg","release_date":"2023-12-06","title":"Migration","video":false,"vote_average":7.559,"vote_count":934},{"adult":false,"backdrop_path":"/nb3xI8XI3w4pMVZ38VijbsyBqP4.jpg","genre_ids":[18,36],"id":872585,"original_language":"en","original_title":"Oppenheimer","overview":"The story of J. Robert Oppenheimer\\u0027s role in the development of the atomic bomb during World War II.","popularity":703.426,"poster_path":"/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg","release_date":"2023-07-19","title":"Oppenheimer","video":false,"vote_average":8.116,"vote_count":7177},{"adult":false,"backdrop_path":"/nTPFkLUARmo1bYHfkfdNpRKgEOs.jpg","genre_ids":[35,10749],"id":1072790,"original_language":"en","original_title":"Anyone But You","overview":"After an amazing first date, Bea and Ben’s fiery attraction turns ice cold — until they find themselves unexpectedly reunited at a destination wedding in Australia. So they do what any two mature adults would do: pretend to be a couple.","popularity":648.976,"poster_path":"/5qHoazZiaLe7oFBok7XlUhg96f2.jpg","release_date":"2023-12-21","title":"Anyone But You","video":false,"vote_average":7.044,"vote_count":997},{"adult":false,"backdrop_path":"/hIUs8RzKlrzgbWxn2EpWmiTFqCc.jpg","genre_ids":[878,53],"id":870404,"original_language":"en","original_title":"Meteor","overview":"After a meteor collides into Earth, a lonely rancher and a lost young girl are on the run from vicious mercenaries.","popularity":575.533,"poster_path":"/tVMddOS5bi3YPVPgTPlEw0TOWoF.jpg","release_date":"2021-09-01","title":"Meteor","video":false,"vote_average":5.5,"vote_count":81},{"adult":false,"backdrop_path":"/yyFc8Iclt2jxPmLztbP617xXllT.jpg","genre_ids":[35,10751,14],"id":787699,"original_language":"en","original_title":"Wonka","overview":"Willy Wonka – chock-full of ideas and determined to change the world one delectable bite at a time – is proof that the best things in life begin with a dream, and if you’re lucky enough to meet Willy Wonka, anything is possible.","popularity":694.201,"poster_path":"/qhb1qOilapbapxWQn9jtRCMwXJF.jpg","release_date":"2023-12-06","title":"Wonka","video":false,"vote_average":7.199,"vote_count":2536},{"adult":false,"backdrop_path":"/wqmemsQb8xcLVQkwt8WTYnMIYms.jpg","genre_ids":[28,35],"id":1217409,"original_language":"es","original_title":"Jaque Mate","overview":"Duque, an international secret agent who retired years ago after a traumatic event, is forced to return to action when a commando operative kidnaps his niece and forces him to steal a precious scientific formula as part of the ransom.","popularity":619.432,"poster_path":"/26VzK0GVAsZhVXIbv3qDKiwBYud.jpg","release_date":"2024-01-25","title":"Jaque Mate","video":false,"vote_average":4.6,"vote_count":6},{"adult":false,"backdrop_path":"/lzWHmYdfeFiMIY4JaMmtR7GEli3.jpg","genre_ids":[878,12],"id":438631,"original_language":"en","original_title":"Dune","overview":"Paul Atreides, a brilliant and gifted young man born into a great destiny beyond his understanding, must travel to the most dangerous planet in the universe to ensure the future of his family and his people. As malevolent forces explode into conflict over the planet\\u0027s exclusive supply of the most precious resource in existence-a commodity capable of unlocking humanity\\u0027s greatest potential-only those who can conquer their fear will survive.","popularity":596.338,"poster_path":"/d5NXSklXo0qyIYkgV94XAgMIckC.jpg","release_date":"2021-09-15","title":"Dune","video":false,"vote_average":7.786,"vote_count":10768},{"adult":false,"backdrop_path":"/G56AzECyTDp63sE7CbJ6AEBKhF.jpg","genre_ids":[37,28],"id":851925,"original_language":"en","original_title":"Death Alley","overview":"In 1892, the Dalton Gang set out to become the most famous outlaws in America. That dream would become a nightmare.","popularity":541.852,"poster_path":"/iIKYK9mdapWlJ21YNRGB57WKErK.jpg","release_date":"2021-03-11","title":"Death Alley","video":false,"vote_average":5.655,"vote_count":29},{"adult":false,"backdrop_path":"/4Ep2KivIBUZbkS7kHjW7Qywnhhj.jpg","genre_ids":[28],"id":1049948,"original_language":"en","original_title":"Vikings: Battle of Heirs","overview":"A young Viking must come to terms with the realization that he may be the King\\u0027s son, who was switched at birth, but not before others try to take his rightful place.","popularity":750.1,"poster_path":"/87goLbbqrJqAxqDS5cBsik1zKT.jpg","release_date":"2023-04-28","title":"Vikings: Battle of Heirs","video":false,"vote_average":7.0,"vote_count":3}],"total_pages":43042,"total_results":860840}';
    final response = await MovieDataSourceImpl().getDiscoverDataFromNative(Constants.API_KEY);
    expect(response, mockResponse);
  });

   test('discover movies list from native return error when send invalid api key', ( ) async {
    final error='Error : some thing went wrong';
    final response = await MovieDataSourceImpl().getDiscoverDataFromNative('eee');
    expect(response, error);
  });

  //discover movies flutter....
   test('discover movies list not empty', ( ) async {
    final response = await MovieDataSourceImpl().getDiscoverMovies(Constants.API_KEY);
    expect(response.isNotEmpty, true);
  });

   test('discover movies list when response is valid', ( ) async {
   var mockList =  dummyData.map((movie) => DiscoverMovies.fromJson(movie)).toList();
    final response = await MovieDataSourceImpl().getDiscoverMovies(Constants.API_KEY);
      expect(response, mockList);
  });

   test('discover movies failure when send invalid api key', ( ) async {
    expect(() => MovieDataSourceImpl().getDiscoverMovies('eee'), throwsA(isA<ServerException>()));
  });

   test('movie details native not empty', ( ) async {
    final response = await MovieDataSourceImpl().getDetailsMovieFromNative(763215 , Constants.API_KEY);
    expect(response.isNotEmpty, true);
  });

   test('movie details native failure when send invalid api key', ( ) async {
    final error='Error : some thing went wrong';
    final response = await MovieDataSourceImpl().getDetailsMovieFromNative(763215,'eee');
    expect(response, error);
  });

//movie details  flutter....
   test('movie details when response is valid', ( ) async {
    DetailsMovieModels detailsMovieModels = DetailsMovieModels.fromJson({
          "adult": false,
          "backdrop_path": "/deLWkOLZmBNkm8p16igfapQyqeq.jpg",
          "belongs_to_collection": null,
          "budget": 60000000,
          "genres": [
            {
              "id": 14,
              "name": "Fantasy"
            },
            {
              "id": 12,
              "name": "Adventure"
            },
            {
              "id": 28,
              "name": "Action"
            }
          ],
          "homepage": "https://www.netflix.com/title/80991090",
          "id": 763215,
          "imdb_id": "tt13452446",
          "original_language": "en",
          "original_title": "Damsel",
          "overview": "A young woman's marriage to a charming prince turns into a fierce fight for survival when she's offered up as a sacrifice to a fire-breathing dragon.",
          "popularity": 1986.779,
          "poster_path": "/sMp34cNKjIb18UBOCoAv4DpCxwY.jpg",
          "production_companies": [
            {
              "id": 121424,
              "logo_path": "/laQkxRzl2PTQFHPKVUE54UM38sw.png",
              "name": "PCMA Productions",
              "origin_country": "US"
            },
            {
              "id": 105052,
              "logo_path": null,
              "name": "Roth-Kirschenbaum Films",
              "origin_country": "US"
            }
          ],
          "production_countries": [
            {
              "iso_3166_1": "US",
              "name": "United States of America"
            }
          ],
          "release_date": "2024-03-08",
          "revenue": 0,
          "runtime": 110,
          "spoken_languages": [
            {
              "english_name": "English",
              "iso_639_1": "en",
              "name": "English"
            }
          ],
          "status": "Released",
          "tagline": "This is not a fairytale.",
          "title": "Damsel",
          "video": false,
          "vote_average": 7.292,
          "vote_count": 751
        });
    final response = await MovieDataSourceImpl().getMovieDetails(763215 , Constants.API_KEY);
     expect(response,detailsMovieModels);

   });

   test('movie details failure when send invalid api key', ( ) async {
    expect(() => MovieDataSourceImpl().getMovieDetails(763215 , 'eee'), throwsA(isA<ServerException>()));
  });

  //movie details from native ......
  //  test('movie details native return successful response', ( ) async {
  //   final mockResponse='{"adult":false,"backdrop_path":"/deLWkOLZmBNkm8p16igfapQyqeq.jpg","budget":60000000,"genres":[{"id":14,"name":"Fantasy"},{"id":12,"name":"Adventure"},{"id":28,"name":"Action"}],"homepage":"https://www.netflix.com/title/80991090","id":763215,"imdb_id":"tt13452446","original_language":"en","original_title":"Damsel","overview":"A young woman\\u0027s marriage to a charming prince turns into a fierce fight for survival when she\\u0027s offered up as a sacrifice to a fire-breathing dragon.","popularity":2754.204,"poster_path":"/sMp34cNKjIb18UBOCoAv4DpCxwY.jpg","production_companies":[{"id":121424,"logo_path":"/laQkxRzl2PTQFHPKVUE54UM38sw.png","name":"PCMA Productions","origin_country":"US"},{"id":105052,"name":"Roth-Kirschenbaum Films","origin_country":"US"}],"production_countries":[{"iso_3166_1":"US","name":"United States of America"}],"release_date":"2024-03-08","revenue":0,"runtime":110,"spoken_languages":[{"english_name":"English","iso_639_1":"en","name":"English"}],"status":"Released","tagline":"This is not a fairytale.","title":"Damsel","video":false,"vote_average":7.292,"vote_count":751}';
  //
  //   final response = await MovieDataSourceImpl().getDetailsMovieFromNative(763215,Constants.API_KEY);
  //   expect(response, mockResponse);
  // });
}
