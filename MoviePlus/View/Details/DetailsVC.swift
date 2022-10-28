//
//  DetailsVC.swift
//  MoviePlus
//
//  Created by İbrahim Taşdemir on 27.10.2022.
//

import UIKit
import SnapKit

class DetailsVC: UIViewController {

    var detailsView = UIView()
    var detailsTitle = UILabel()
    var detailsImage = UIImageView()
    var detailsOverview = UILabel()
    var imageUrl : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewEdit()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [self] in
            detailsImage.setImageWithKF(url: imageUrl!, size: detailsImage.bounds.size)
            
        }
    }
    
    private func viewEdit() {
        detailsTitle.font = UIFont(name: "OpenSans-Bold", size: 24)
        detailsTitle.textColor = primaryColor
        detailsTitle.textAlignment = .center
        
        detailsImage.contentMode = .scaleToFill
        detailsImage.layer.masksToBounds = true
        detailsImage.layer.cornerRadius = 14
        
        detailsOverview.font = .FontsBy.openSansMedium.fonts
        detailsOverview.textDropShadow()
        detailsOverview.textAlignment = .center
        detailsOverview.numberOfLines = 0
        detailsOverview.sizeToFit()
    }

    private func configure() {
        view.addSubview(detailsView)
        detailsView.addSubview(detailsTitle)
        detailsView.addSubview(detailsImage)
        detailsView.addSubview(detailsOverview)
        
        detailsView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(view.safeAreaLayoutGuide.snp.width)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        detailsTitle.snp.makeConstraints { make in
            make.top.equalTo(detailsView.snp.top)
            make.width.equalTo(detailsView.snp.width)
            make.height.equalTo(detailsView.snp.height).multipliedBy(0.1)
        }
        detailsImage.snp.makeConstraints { make in
            make.top.equalTo(detailsTitle.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(detailsView.snp.width).multipliedBy(0.8)
            make.height.equalTo(detailsView.snp.height).multipliedBy(0.5)
        }
        detailsOverview.snp.makeConstraints { make in
            make.top.equalTo(detailsImage.snp.bottom)
            make.width.equalTo(detailsView.snp.width)
            make.height.equalTo(detailsView.snp.height).multipliedBy(0.35)
        }
    }
}
