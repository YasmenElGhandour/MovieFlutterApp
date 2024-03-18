//
//  MovieManager.swift
//  Runner
//
//  Created by mac on 3/18/24.
//

import UIKit

struct MovieManager {

    
    func fetchDiscoverMovies(result: @escaping FlutterResult , apiKey: String){
            guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)")
        else {return}
        let dataTask = URLSession.shared.dataTask(with: url){ (data,response, error) in
             if let error = error {
                 print("error")
                 result(FlutterError(code: "UNAVAILABLE",
                                     message: "Server Error",
                                     details: nil))
             }
             if let jsonData = data {
               do {
                   let discoverMovies = try JSONDecoder().decode(DiscoverMovies.self, from: data!)
                   //convert discoverMovies model to json then to string
                   let jsonData = try JSONEncoder().encode(discoverMovies)
                    let jsonString = String(data: jsonData, encoding: .utf8)!
                     result(jsonString)
                 //  result(discoverMovies) // Pass through the FlutterError
               } catch let decoderError {
                   print("error decoding")
                   result(FlutterError(code: "UNAVAILABLE",
                                       message: "Server Error",
                                       details: nil))
               }
             }

        }.resume()
    }


    
    func fetchDetailsMovie(result : @escaping FlutterResult , apiKey:String , movieId:Int) {
        print("testttttt")
       guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(apiKey)")
        else {return}
        let dataTask = URLSession.shared.dataTask(with: url){ (data, response, error) in
             if let error = error {
                 result(FlutterError(code: "UNAVAILABLE details",
                                     message: "Server Error",
                                     details: nil))
             }
            print("details \(data)")

             if let jsonData = data {
               do {
                   let details = try JSONDecoder().decode(DetailsMovie.self, from: data!)
                   print("details \(details)")
//                   let jsonData = try JSONEncoder().encode(details)
//                    let jsonString = String(data: jsonData, encoding: .utf8)!
  //                  print("jsonStringdetails \(jsonString)")
                    result(details)
               } catch let decoderError {
                   print("error decoding \(decoderError)")
                   result(FlutterError(code: "UNAVAILABLE",
                                       message: "Server Error",
                                       details: nil))
                   
               }
             }

        }.resume()
    }

    
}

