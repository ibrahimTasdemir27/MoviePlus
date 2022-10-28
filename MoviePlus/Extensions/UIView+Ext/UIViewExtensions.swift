//
//  UIViewExtensions.swift
//  MoviePlus
//
//  Created by İbrahim Taşdemir on 27.10.2022.
//

import UIKit

extension UIView {
    func textDropShadow() {
            self.layer.masksToBounds = false
            self.layer.shadowRadius = 2.0
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 1, height: 2)
        }
}
