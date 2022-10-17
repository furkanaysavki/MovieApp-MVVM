//
//  NetworkManager.swift
//  MovieApp2
//
//  Created by Furkan Ayşavkı on 16.10.2022.
//

import Foundation
import Alamofire

class NetworkManager : ListMovieData, GetDetailData{
   
    
    enum Api {
        static let baseUrl = "https://www.omdbapi.com/"
        static let apiKey = "3c3c5e32"
    }
    // For main page
    func fetchMovieData(with search : String, completionHandler: @escaping (SearchModel) -> Void){
        AF.request("\(Api.baseUrl)?apikey=\(Api.apiKey)&s=\(search)")
                
            .responseDecodable(of:SearchModel.self) { response in
                guard let movies = response.value else { return }
                completionHandler(movies)
                }
        }
    
        
        // For detail page
    func fetchMovieDetail(id: String, completionHandler: @escaping((DetailModel) -> Void)){
        AF.request("\(Api.baseUrl)?apikey=\(Api.apiKey)&i=\(id )")
              
                .responseDecodable(of:DetailModel.self) { (response) in
                    
                    guard let details = response.value else { return }
                    completionHandler(details)
                }
        }
       // For error
    func error(with search: String, completion: @escaping((FailModel) -> Void)){
        AF.request("\(Api.baseUrl)?apikey=\(Api.apiKey)&s=\(search)")
                .validate()
                .responseDecodable(of:FailModel.self) { (response) in
                    guard let error = response.value else { return }
                    completion(error)
                }
        }
}
