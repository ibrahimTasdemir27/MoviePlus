//
//  HomePageVC.swift
//  MoviePlus
//
//  Created by İbrahim Taşdemir on 26.10.2022.
//

import UIKit
import Kingfisher

class HomePageVC: UIViewController, UITableViewDelegate {
    
    private var movieDict : [MovieResultModel] = []
    private var movieViewModel : MovieViewModel!
    private var dataSource : MovieTableViewDataSource<HomePageTableViewCell,MovieResultModel>!
    private var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.register(HomePageTableViewCell.nib, forCellReuseIdentifier: HomePageTableViewCell.identifier)
        configure()
        getService()
        callToViewModelForUpdate()
    }

    func callToViewModelForUpdate() {
        self.movieViewModel = MovieViewModel()
        self.movieViewModel.bindMovieViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func configure() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func updateDataSource() {
        self.dataSource = MovieTableViewDataSource(cellIdentifier: HomePageTableViewCell.identifier, items: self.movieViewModel.movieData, configureCell: { cell, mvm in
            cell.movieTitle.text = mvm.original_title
            cell.movieOverview.text = mvm.overview
            cell.moviePoster.setImageWithKF(url: imagaBaseUrl + mvm.poster_path, size: cell.moviePoster.bounds.size)
            cell.cellEdit()
        })
        
        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
        
    }
    
    func getService() {
        let services = APIService()
        services.getData { result in
            switch result{
            case .success(let data):
                self.movieDict = data
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenHeight * 0.2
    }

}
