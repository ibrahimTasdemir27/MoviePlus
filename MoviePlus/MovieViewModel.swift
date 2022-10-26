//
//  MovieViewModel.swift
//  MoviePlus
//
//  Created by İbrahim Taşdemir on 26.10.2022.
//

import Foundation

class MovieViewModel : NSObject {
    
    private var apiService : APIService!
    private(set) var movieData : [MovieResultModel]! {
        didSet {
            self.bindMovieViewModelToController()
        }
    }
    
    var bindMovieViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIService()
        callToGetMovieData()
        
    }
    
    func callToGetMovieData() {
        self.apiService.getData { result in
            switch result {
            case .success(let movieInfo):
                self.movieData = movieInfo
            case .failure(let error):
                print(error)
            }
        }
    }
}
