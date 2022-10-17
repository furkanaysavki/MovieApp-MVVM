//
//  ListMovieData.swift
//  MovieApp2
//
//  Created by Furkan Ayşavkı on 16.10.2022.
//


import Foundation

protocol ListMovieData {
    func fetchMovieData(with search : String, completionHandler: @escaping (SearchModel) -> Void)
    func error(with search: String, completion: @escaping (FailModel) -> Void)
}
protocol GetDetailData {
    func fetchMovieDetail(id: String, completionHandler: @escaping((DetailModel) -> Void))
}
