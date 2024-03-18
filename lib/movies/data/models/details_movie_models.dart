import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


class DetailsMovieModels extends Equatable{
  String? homepage;
  String? posterPath;
  String? originalTitle;
  List<ProductionCompanies>? productionCompanies;
  int? budget;
  String? title;
  int? runtime;
  int? id;
  double? voteAverage;
  String? originalLanguage;
  bool? adult;
  String? backdropPath;
  List<ProductionCountries>? productionCountries;
  String? imdbId;
  bool? video;
  String? tagline;
  String? overview;
  double? popularity;
  BelongsToCollection? belongsToCollection;
  List<Genres>? genres;
  int? revenue;
  String? releaseDate;
  int? voteCount;
  List<SpokenLanguages>? spokenLanguages;
  String? status;

  DetailsMovieModels(
      {this.homepage,
        this.posterPath,
        this.originalTitle,
        this.productionCompanies,
        this.budget,
        this.title,
        this.runtime,
        this.id,
        this.voteAverage,
        this.originalLanguage,
        this.adult,
        this.backdropPath,
        this.productionCountries,
        this.imdbId,
        this.video,
        this.tagline,
        this.overview,
        this.popularity,
        this.belongsToCollection,
        this.genres,
        this.revenue,
        this.releaseDate,
        this.voteCount,
        this.spokenLanguages,
        this.status});

  DetailsMovieModels.fromJson(Map<String, dynamic> json) {
    homepage = json['homepage'];
    posterPath = json['poster_path'];
    originalTitle = json['original_title'];
    if (json['production_companies'] != null) {
      productionCompanies = <ProductionCompanies>[];
      json['production_companies'].forEach((v) {
        productionCompanies!.add(new ProductionCompanies.fromJson(v));
      });
    }
    budget = json['budget'];
    title = json['title'];
    runtime = json['runtime'];
    id = json['id'];
    voteAverage = json['vote_average'];
    originalLanguage = json['original_language'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    if (json['production_countries'] != null) {
      productionCountries = <ProductionCountries>[];
      json['production_countries'].forEach((v) {
        productionCountries!.add(new ProductionCountries.fromJson(v));
      });
    }
    imdbId = json['imdb_id'];
    video = json['video'];
    tagline = json['tagline'];
    overview = json['overview'];
    popularity = json['popularity'];
    belongsToCollection = json['belongs_to_collection'] != null
        ? new BelongsToCollection.fromJson(json['belongs_to_collection'])
        : null;
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(new Genres.fromJson(v));
      });
    }
    revenue = json['revenue'];
    releaseDate = json['release_date'];
    voteCount = json['vote_count'];
    if (json['spoken_languages'] != null) {
      spokenLanguages = <SpokenLanguages>[];
      json['spoken_languages'].forEach((v) {
        spokenLanguages!.add(new SpokenLanguages.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['homepage'] = this.homepage;
    data['poster_path'] = this.posterPath;
    data['original_title'] = this.originalTitle;
    if (this.productionCompanies != null) {
      data['production_companies'] =
          this.productionCompanies!.map((v) => v.toJson()).toList();
    }
    data['budget'] = this.budget;
    data['title'] = this.title;
    data['runtime'] = this.runtime;
    data['id'] = this.id;
    data['vote_average'] = this.voteAverage;
    data['original_language'] = this.originalLanguage;
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    if (this.productionCountries != null) {
      data['production_countries'] =
          this.productionCountries!.map((v) => v.toJson()).toList();
    }
    data['imdb_id'] = this.imdbId;
    data['video'] = this.video;
    data['tagline'] = this.tagline;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    if (this.belongsToCollection != null) {
      data['belongs_to_collection'] = this.belongsToCollection!.toJson();
    }
    if (this.genres != null) {
      data['genres'] = this.genres!.map((v) => v.toJson()).toList();
    }
    data['revenue'] = this.revenue;
    data['release_date'] = this.releaseDate;
    data['vote_count'] = this.voteCount;
    if (this.spokenLanguages != null) {
      data['spoken_languages'] =
          this.spokenLanguages!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }

  @override
  List<Object?> get props => [
    adult,
    homepage,
    id,
    imdbId,
    originalLanguage,
    originalTitle,
    overview,
    spokenLanguages,
    status,
    tagline,
    title,
    video,
  ];
}

class ProductionCompanies extends Equatable {
  String? name;
  String? originCountry;
  String? logoPath;
  int? id;

  ProductionCompanies({this.name, this.originCountry, this.logoPath, this.id});

  ProductionCompanies.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    originCountry = json['origin_country'];
    logoPath = json['logo_path'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['origin_country'] = this.originCountry;
    data['logo_path'] = this.logoPath;
    data['id'] = this.id;
    return data;
  }

  @override
  List<Object?> get props => [id,name];
}

class ProductionCountries extends Equatable{
  String? iso31661;
  String? name;

  ProductionCountries({this.iso31661, this.name});

  ProductionCountries.fromJson(Map<String, dynamic> json) {
    iso31661 = json['iso_3166_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso_3166_1'] = this.iso31661;
    data['name'] = this.name;
    return data;
  }
  @override
  List<Object?> get props => [iso31661 , name];
}

class BelongsToCollection extends Equatable {
  int? id;

  BelongsToCollection({this.id});

  BelongsToCollection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }

  @override
  List<Object?> get props => [id];
}

class Genres extends Equatable {
  String? name;
  int? id;

  Genres({this.name, this.id});

  Genres.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
  @override
  List<Object?> get props => [id,name];
}

class SpokenLanguages extends Equatable{
  String? name;
  String? iso6391;
  String? englishName;

  SpokenLanguages({this.name, this.iso6391, this.englishName});

  SpokenLanguages.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    iso6391 = json['iso_639_1'];
    englishName = json['english_name'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['iso_639_1'] = this.iso6391;
    data['english_name'] = this.englishName;
    return data;
  }

  @override
  List<Object?> get props => [englishName,iso6391,name];

}