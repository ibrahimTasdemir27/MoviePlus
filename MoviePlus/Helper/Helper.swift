//
//  Helper.swift
//  MoviePlus
//
//  Created by İbrahim Taşdemir on 26.10.2022.
//

import UIKit

enum Icons : CaseIterable{
    case home
    case favorites
    case profile
    
    var imageName : UIImage {
        switch self {
        case .home :             return UIImage(systemName: "house") ?? UIImage()
        case .favorites :        return UIImage(systemName: "heart") ?? UIImage()
        case .profile :          return UIImage(systemName: "person") ?? UIImage()
        }
    }
}

enum otherIcons {
    case notFavorite
    
    var imageName : UIImage {
        switch self{
        case .notFavorite :     return UIImage(systemName: "heart.fill") ?? UIImage()
        }
    }
}
