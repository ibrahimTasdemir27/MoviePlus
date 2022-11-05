//
//  HomePageTableViewCell.swift
//  MoviePlus
//
//  Created by İbrahim Taşdemir on 26.10.2022.
//

import UIKit
import SnapKit
import Kingfisher

class HomePageTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellView: UIView!
    var moviePoster = UIImageView()
    var movieTitle = UILabel()
    var movieOverview = UILabel()
    var movieFavorite = UIButton()
    class var identifier: String  {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var movieVM : MovieResultModel? {
        didSet{
            movieTitle.text = movieVM?.original_title
            movieOverview.text = movieVM?.overview
        }
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
        
        movieFavorite.imageView?.tintColor = .systemRed
        movieFavorite.backgroundColor = .clear
    }
    
    func configure() {
        cellView.addSubview(movieTitle)
        cellView.addSubview(moviePoster)
        cellView.addSubview(movieOverview)
        cellView.addSubview(movieFavorite)
        
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
            make.right.equalTo(movieFavorite.snp.left)
            make.height.equalToSuperview().multipliedBy(0.58)
        }
        movieFavorite.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-screenWidth * 0.025)
            make.bottom.equalTo(movieOverview.snp.bottom).offset(3)
            make.width.equalToSuperview().multipliedBy(0.1)
            make.height.equalToSuperview().multipliedBy(0.25)
        }
    }
    
    func changing(id : Int) {
        if CoreDataServices.shared.checkFavorites(id: id) {
            movieFavorite.setImage(otherIcons.notFavorite.imageName.withConfiguration(otherIcons.notFavorite.imageName.config()), for: UIControl.State.normal)
        }else{
            movieFavorite.setImage(Icons.favorites.imageName.withConfiguration(Icons.favorites.imageName.config()), for: UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

    
}
