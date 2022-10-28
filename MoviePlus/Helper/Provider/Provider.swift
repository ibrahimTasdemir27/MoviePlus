//
//  Provider.swift
//  MoviePlus
//
//  Created by İbrahim Taşdemir on 26.10.2022.
//

import UIKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let primaryColor = UIColor.rgba(242,43,120,255).withAlphaComponent(0.7)
let secondaryColor = UIColor.darkGray.withAlphaComponent(0.9)
let usDef = UserDefaults.standard
let imagaBaseUrl = "https://image.tmdb.org/t/p/w500"
let baseUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=50bbd6f582cd05dd01b18c5309bc9ae5"
