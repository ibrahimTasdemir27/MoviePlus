//
//  ColorExtension.swift
//  MoviePlus
//
//  Created by İbrahim Taşdemir on 26.10.2022.
//

import UIKit
extension UIColor {
       static func rgba(_ red: Int, _ green: Int, _ blue: Int, _ alpha: Double) -> UIColor {
           assert(red >= 0 && red <= 255, "Invalid red component")
           assert(green >= 0 && green <= 255, "Invalid green component")
           assert(blue >= 0 && blue <= 255, "Invalid blue component")
   
           return self.init(red: CGFloat(red) / 255.0,
                            green: CGFloat(green) / 255.0,
                            blue: CGFloat(blue) / 255.0,
                            alpha: alpha)
       }
   }
