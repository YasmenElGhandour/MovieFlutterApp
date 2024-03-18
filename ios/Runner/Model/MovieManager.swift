//
//  MovieManager.swift
//  Runner
//
//  Created by mac on 3/18/24.
//

import UIKit

struct MovieManager {
    
        
    func fetchDiscoverMovies(result : FlutterResult , apiKey:String) {
       guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)")
        else {return }
        let dataTask = URLSession.shared.dataTask(with: url){ (data, _, error) in
             if let error = error {
                 print("error")
             }
             if let jsonData = data {
               do {
                   let discoverMovies : DiscoverMovies = try JSONDecoder().decode(DiscoverMovies.self, from: data!)
                   let jsonEncoder = JSONEncoder()
                   let jsonData = try jsonEncoder.encode(data)
                   let json = String(data: jsonData, encoding: String.Encoding.utf8)
                   print("discoverMovies \(discoverMovies)")
                   result(json)

               } catch let decoderError {
                   print("error decoding")

               }
             }

        }.resume()


    }
    
    
    func fetchDetailsMovie(result : FlutterResult , apiKey:String , movieId:Int) {
       guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(apiKey)")
        else {return}
        let dataTask = URLSession.shared.dataTask(with: url){ (data, _, error) in
             if let error = error {
                 print("error")
             }
             if let jsonData = data {
               do {
                   let details = try JSONDecoder().decode(DetailsMovie.self, from: data!)
                   let jsonEncoder = JSONEncoder()
                   let jsonData = try jsonEncoder.encode(details)
                   let json = String(data: jsonData, encoding: String.Encoding.utf8)
                
               } catch let decoderError {
                   print("error decoding")
               }
             }

        }.resume()
    }


}
