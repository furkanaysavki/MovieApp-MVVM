//
//  MovieDetailViewModel.swift
//  MovieApp2
//
//  Created by Furkan Ayşavkı on 16.10.2022.
//

import Foundation
class DetailViewModel {
    
  
    weak var detailOutput : DetailViewModelOutput?
    private let getDetailData : GetDetailData
    init(getDetailData : GetDetailData) {
        self.getDetailData = getDetailData
    }
    
    func fetchDetail(with id : String) {
        getDetailData.fetchMovieDetail(id: id ) { [weak self] result in
            self?.detailOutput?.detailView(director: result.Director!, actor: result.Actors!, plot: result.Plot!, genre: result.Genre!, imdb: result.imdbRating!, poster: result.Poster!)
            print(result)
        }
    }
}
