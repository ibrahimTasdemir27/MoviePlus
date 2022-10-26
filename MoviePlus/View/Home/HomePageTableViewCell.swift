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

    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
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
        moviePoster.contentMode = .scaleToFill
        moviePoster.layer.cornerRadius = 8
        
        movieTitle.textAlignment = .left
        movieTitle.font = .FontsBy.openSansBold.fonts
        movieTitle.textColor = primaryColor
        
        movieOverview.numberOfLines = 0
        movieOverview.font = .FontsBy.openSansRegular.fonts
        
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

    
}
