//
//  HomePageVC.swift
//  MoviePlus
//
//  Created by İbrahim Taşdemir on 26.10.2022.
//

import UIKit
import Kingfisher
import SwiftyJSON

class HomePageVC: UIViewController, UITableViewDelegate {
    
    private var movieDict : [MovieResultModel] = []
    private var movieViewModel : MovieViewModel!
    private var dataSource : MovieTableViewDataSource<HomePageTableViewCell,MovieResultModel>!
    private var tableView = UITableView()
    private let services = APIService()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewEdit()
        configure()
        getService()
        callToViewModelForUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // tableView.reloadData()
    }

    func callToViewModelForUpdate() {
        self.movieViewModel = MovieViewModel()
        self.movieViewModel.bindMovieViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource() {
        self.dataSource = MovieTableViewDataSource(cellIdentifier: HomePageTableViewCell.identifier, items: self.movieViewModel.movieData, configureCell: { cell, mvm in
            cell.movieFavorite.addTarget(self, action: #selector(self.isFavorite), for: UIControl.Event.touchUpInside)
            cell.movieTitle.text = mvm.original_title
            cell.movieOverview.text = mvm.overview
            cell.configure()
            cell.cellEdit()
            cell.changing(id: mvm.id)
            DispatchQueue.main.async {
                cell.moviePoster.setImageWithKF(url: imagaBaseUrl + mvm.poster_path, size: cell.moviePoster.bounds.size)
            }
           
        })
        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }
    
    @objc func isFavorite(_ sender : UIButton) {
        let point = tableView.convert(CGPoint.zero, from: sender)
        if let indexPath = tableView.indexPathForRow(at: point){
            if CoreDataServices.shared.checkFavorites(id: movieDict[indexPath.row].id){
                CoreDataServices.shared.removeFavorites(id: movieDict[indexPath.row].id)
            }else{
                CoreDataServices.shared.saveCore(id: movieDict[indexPath.row].id)
            }
            tableView.reloadData()
        }
    }
    
    func viewEdit() {
        tableView.delegate = self
        tableView.register(HomePageTableViewCell.nib, forCellReuseIdentifier: HomePageTableViewCell.identifier)
    }
    
    func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func getService() {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goDetails(index: indexPath.row)
    }
    
    func goDetails(index : Int) {
        let vc = DetailsVC()
        vc.detailsTitle.text  = movieDict[index].original_title
        vc.detailsOverview.text = movieDict[index].overview
        vc.imageUrl = imagaBaseUrl + movieDict[index].poster_path
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
}
