//
//  MovieViewModelOutput.swift
//  MovieApp2
//
//  Created by Furkan Ayşavkı on 16.10.2022.
//

import Foundation

protocol MovieViewModelOutput : AnyObject {
    func updateView(search : [Search], response : String)
}
protocol ErrorViewModelOutput : AnyObject {
    func errorView(response : String, message : String)
}
protocol DetailViewModelOutput : AnyObject {
    func detailView(director : String, actor : String, plot : String, genre : String, imdb : String, poster : String )
}

