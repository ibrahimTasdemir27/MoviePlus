//
//  UIImageExtensions.swift
//  MoviePlus
//
//  Created by İbrahim Taşdemir on 27.10.2022.
//

import UIKit

extension UIImage{
    func config(size : CGFloat = 24) -> UIImage.SymbolConfiguration {
        let config = UIImage.SymbolConfiguration(
            pointSize: size, weight: .regular, scale: .default)
        return config
    }
}
