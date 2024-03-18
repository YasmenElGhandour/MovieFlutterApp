// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let detailsMovie = try? JSONDecoder().decode(DetailsMovie.self, from: jsonData)

import Foundation

// MARK: - DetailsMovie
struct DetailsMovie: Codable {
    let homepage: String
    let posterPath, originalTitle: String
    let productionCompanies: [ProductionCompany]
    let budget: Int
    let title: String
    let runtime, id: Int
    let voteAverage: Double
    let originalLanguage: String
    let adult: Bool
    let backdropPath: String
    let productionCountries: [ProductionCountry]
    let imdbID: String
    let video: Bool
    let tagline, overview: String
    let popularity: Double
    let belongsToCollection: [BelongsToCollection]
    let genres: [Genre]
    let revenue: Int
    let releaseDate: String
    let voteCount: Int
    let spokenLanguages: [SpokenLanguage]
    let status: String

    enum CodingKeys: String, CodingKey {
        case homepage
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case productionCompanies = "production_companies"
        case budget, title, runtime, id
        case voteAverage = "vote_average"
        case originalLanguage = "original_language"
        case adult
        case backdropPath = "backdrop_path"
        case productionCountries = "production_countries"
        case imdbID = "imdb_id"
        case video, tagline, overview, popularity
        case belongsToCollection = "belongs_to_collection"
        case genres, revenue
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case spokenLanguages = "spoken_languages"
        case status
    }
}

// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
    let id: Int?
    let belongsToCollection:String
    let debugDescription:String?

    enum CodingKeys: String, CodingKey {
        case belongsToCollection = "belongs_to_collection"
        case id
        case debugDescription="debugDescription"
    }
    
}

// MARK: - Genre
struct Genre: Codable {
    let name: String
    let id: Int
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let name, originCountry: String
    let logoPath: String?
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name
        case originCountry = "origin_country"
        case logoPath = "logo_path"
        case id
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let name, iso639_1, englishName: String

    enum CodingKeys: String, CodingKey {
        case name
        case iso639_1 = "iso_639_1"
        case englishName = "english_name"
    }
}
