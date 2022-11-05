//
//  FavoritesTableViewCell.swift
//  MoviePlus
//
//  Created by İbrahim Taşdemir on 28.10.2022.
//

import UIKit
import SnapKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    var moviePoster = UIImageView()
    var movieTitle = UILabel()
    var movieOverview = UILabel()
    
    class var identifier: String  {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func cellEdit() {
        moviePoster.layer.masksToBounds = true
        moviePoster.contentMode = .scaleToFill
        moviePoster.layer.cornerRadius = 8
        
        movieTitle.textAlignment = .left
        movieTitle.font = .FontsBy.openSansBold.fonts
        movieTitle.textColor = primaryColor
        
        movieOverview.numberOfLines = 0
        movieOverview.textColor = UIColor.black.withAlphaComponent(0.75)
        movieOverview.textDropShadow()
        movieOverview.font = .FontsBy.openSansMedium.fonts
    }
    
    func configure() {
        cellView.addSubview(movieTitle)
        cellView.addSubview(moviePoster)
        cellView.addSubview(movieOverview)
        
        cellView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        moviePoster.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(screenWidth * 0.025)
            make.top.equalToSuperview().offset(screenWidth * 0.025)
            make.width.equalToSuperview().multipliedBy(0.35)
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        movieTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(screenWidth * 0.025)
            make.left.equalTo(moviePoster.snp.right).offset(10)
            make.right.equalToSuperview().offset(-screenWidth * 0.025)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        movieOverview.snp.makeConstraints { make in
            make.top.equalTo(movieTitle.snp.bottom)
            make.left.equalTo(moviePoster.snp.right).offset(10)
            make.right.equalToSuperview().offset(-screenWidth * 0.1)
            make.height.equalToSuperview().multipliedBy(0.58)
        }
    }
    
    
    
}
