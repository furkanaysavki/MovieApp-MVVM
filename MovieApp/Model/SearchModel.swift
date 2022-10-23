//
//  SearchModel.swift
//  MovieApp2
//
//  Created by Furkan Ayşavkı on 16.10.2022.
//

import Foundation

struct SearchModel: Codable {
   
    let search: [Search]
    let totalResults, response: String
 
    enum CodingKeys: String, CodingKey {
          case search = "Search"
          case totalResults
          case response = "Response"
          
    }
  }

 struct Search: Codable {
      let title, year, imdbID, type: String
      let poster: String
   
      enum CodingKeys: String, CodingKey {
          case title = "Title"
          case year = "Year"
          case imdbID
          case type = "Type"
          case poster = "Poster"
         
      }
  }
