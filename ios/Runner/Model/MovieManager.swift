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
             }
             if let jsonData = data {
               do {
                   let discoverMovies = try JSONDecoder().decode(DiscoverMovies.self, from: data!)
                   //convert discoverMovies model to json then to string
                     result("\(jsonData)")
                 //  result(discoverMovies) // Pass through the FlutterError
               } catch let decoderError {
                   print("error decoding")
               }
             }

        }.resume()
    }


    
    func fetchDetailsMovie(result : @escaping FlutterResult , apiKey:String , movieId:Int) {
       guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(apiKey)")
        else {return}
        let dataTask = URLSession.shared.dataTask(with: url){ (data, _, error) in
             if let error = error {
                 print("error")
             }
             if let jsonData = data {
               do {
                   let details = try JSONDecoder().decode(DetailsMovie.self, from: data!)
                  // let jsonData = try JSONEncoder().encode(details)
                    result(details)
               } catch let decoderError {
                   print("error decoding")
               }
             }

        }.resume()
    }
    
}

//extension Encodable {
//
//    /// Converting object to postable dictionary
//    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
//        let data = try encoder.encode(self)
//        let object = try JSONSerialization.jsonObject(with: data)
//        if let json = object as? [String: Any]  { return json }
//        
//        let context = DecodingError.Context(codingPath: [], debugDescription: "Deserialized object is not a dictionary")
//        throw DecodingError.typeMismatch(type(of: object), context)
//    }
//}
//
//extension Encodable {
//    /// Converting object to postable JSON
//    func toJSON(_ encoder: JSONEncoder = JSONEncoder()) throws -> NSString {
//        let data = try encoder.encode(self)
//        let result = String(decoding: data, as: UTF8.self)
//        return NSString(string: result)
//    }
//}
