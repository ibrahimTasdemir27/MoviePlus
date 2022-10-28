
//
//  ImageExtensions.swift
//  MoviePlus
//
//  Created by İbrahim Taşdemir on 27.10.2022.
//

import UIKit
import Kingfisher

extension UIImageView{
    func setImageWithKF(url: String, size: CGSize) {
        let proccess =  DownsamplingImageProcessor(size: size)
            self.kf.setImage(with: URL(string: url),
                             placeholder: .none,
                             options: [.processor(proccess), .scaleFactor(UIScreen.main.scale)], completionHandler: nil)
        }
    }
