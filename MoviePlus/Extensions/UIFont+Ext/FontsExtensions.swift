//
//  FontsExtensions.swift
//  MoviePlus
//
//  Created by İbrahim Taşdemir on 27.10.2022.
//

import UIKit

extension UIFont{
    
    enum FontsBy {
        case openSansBold
        case openSansMedium
        case openSansRegular
        
        var fonts : UIFont {
            switch self {
            case .openSansBold :     return UIFont(name: "OpenSans-Bold", size: 17)!
            case .openSansMedium :   return UIFont(name: "OpenSans-Medium", size: 17)!
            case .openSansRegular :  return UIFont(name: "OpenSans-Regular", size: 17)!
                
            }
        }
    }
    
}

