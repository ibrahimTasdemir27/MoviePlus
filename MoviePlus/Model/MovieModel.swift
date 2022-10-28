//
//  MovieModel.swift
//  MoviePlus
//
//  Created by İbrahim Taşdemir on 26.10.2022.
//

import Foundation

struct MovieModel : Codable{
    let results : [MovieResultModel]
    
    enum CodingKeys : String,CodingKey {
        case results
    }
}

struct MovieResultModel :Codable {
    let original_title : String
    let overview : String
    let poster_path : String
    let id : Int
}
