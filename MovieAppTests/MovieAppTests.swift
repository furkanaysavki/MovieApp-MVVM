//
//  MovieApp2Tests.swift
//  MovieApp2Tests
//
//  Created by Furkan Ayşavkı on 16.10.2022.
//

import XCTest
@testable import MovieApp
class MovieAppTests: XCTestCase {
   
    
        
        private var detailViewModel : DetailViewModel!
        private var getDetailData : MockGetDetailData!
        private var output : MockDetailOutput!

        override func setUpWithError() throws {
            getDetailData = MockGetDetailData()
            detailViewModel = DetailViewModel(getDetailData: getDetailData)
            output = MockDetailOutput()
            detailViewModel.detailOutput = output
        }

        override func tearDownWithError() throws {
          detailViewModel = nil
          getDetailData = nil
        }

        func testWhenUpdateDetailViewSuccess() throws {
            let mockDetail = DetailModel(Title: "Batman", Year: "2005", Rated: "PG-13", Released: "15 Jun 2005", Runtime: "140 min", Genre: "Action", Director: "Christopher Nolan", Writer: "Bob Kane", Actors: "Christian Bale", Plot: "", Language: "English", Country: "United States", Awards: "", Poster: "", Metascore: "", imdbRating : "", imdbVotes: "", imdbID: "", Type: "", DVD: "", BoxOffice: "", Production: "", Website: "", Response: "")
          
          
            getDetailData.fetchDetailMockResult = mockDetail
            detailViewModel.fetchDetail(with: "")
            XCTAssertEqual(output.detailViewArray.first?.actor, "Christian Bale")
        }

        
    }
    class MockGetDetailData : GetDetailData {
        var fetchDetailMockResult : DetailModel?
        func fetchMovieDetail(id: String, completionHandler: @escaping ((DetailModel) -> Void)) {
            if let result = fetchDetailMockResult {
                completionHandler(result)
                
            }
        }
    }
    class MockDetailOutput : DetailViewModelOutput {
        var detailViewArray : [(director: String, actor: String, plot: String, genre: String, imdb: String, poster: String)] = []
        func detailView(director: String, actor: String, plot: String, genre: String, imdb: String, poster: String) {
            detailViewArray.append((director, actor, plot, genre, imdb, poster))
        }
        
        
    }
