//
//  MovieManager.swift
//  Runner
//
//  Created by mac on 3/18/24.
//

import UIKit

struct MovieManager {
    
    
//    func fetchDiscoverMovies( apiKey: String , completion: @escaping (DiscoverMovies) -> Void) {
//
//        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)") else {
//          return
//            //result(FlutterError(code: "INVALID_URL", message: "Failed to create URL", details: nil))
//        }
//        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//               // result(FlutterError(code: "NETWORK_ERROR", message: error.localizedDescription, details: nil))
//            } else if let data = data {
//                do {
//                    let discoverMovies = try JSONDecoder().decode(DiscoverMovies.self, from: data)
//                   completion(discoverMovies)
//                  //  result(json)
//                  //  print("discoverMovies \(json)")
//                } catch {
//                 //   result(FlutterError(code: "JSON_DECODE_ERROR", message: "Failed to decode JSON", details: nil))
//                }
//            } else {
//                // Handle the case where there's no data
//             //   result(FlutterError(code: "NO_DATA", message: "No data received", details: nil))
//            }
//        }
//        dataTask.resume()
//        
//    }
    
    
    func fetchDiscoverMovies(apiKey: String) async -> String {
        do {
            guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)") else {
//                throw FlutterError(code: "INVALID_URL", message: "Failed to create URL", details: nil)
                return ""
            }

            let (data, response) = try await URLSession.shared.data(from: url)

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
//                throw FlutterError(code: "HTTP_ERROR", message: "HTTP error \(httpResponse.statusCode)", details: nil)
            }

            let discoverMovies = try JSONDecoder().decode(DiscoverMovies.self, from: data)
            let json = String(describing: discoverMovies)
          //  print("discoverMovies \(json)")
            return json
        } catch {
//            throw FlutterError(code: "FETCH_ERROR", message: error.localizedDescription, details: nil)
            return ""

        }
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
