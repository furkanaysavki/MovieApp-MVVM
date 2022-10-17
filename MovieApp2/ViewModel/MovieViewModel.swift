//
//  MovieViewModel.swift
//  MovieApp2
//
//  Created by Furkan Ayşavkı on 16.10.2022.
//

import Foundation
import UIKit

class MovieViewModel {
    
    weak var output : MovieViewModelOutput?
    weak var errorOutput : ErrorViewModelOutput?
    private let listMovieData : ListMovieData
    init(listMovieData : ListMovieData) {
        self.listMovieData = listMovieData
    }
    
    
    func fetchMovieData(with searchText : String) {
        let group = DispatchGroup()
        group.enter()
        listMovieData.fetchMovieData(with: searchText) { [weak self] result in
            self?.output?.updateView(search: result.search, response: result.response)
            group.leave()
        }
        group.enter()
        listMovieData.error(with: searchText) { [weak self] result in
            self?.errorOutput?.errorView(response: result.response, message: result.error)
            group.leave()
        }
    }
}
