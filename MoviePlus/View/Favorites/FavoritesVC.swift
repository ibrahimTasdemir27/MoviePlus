//
//  FavoritesVC.swift
//  MoviePlus
//
//  Created by İbrahim Taşdemir on 26.10.2022.
//

import UIKit
import SnapKit

class FavoritesVC: UIViewController {
    
    private var movieDict : [MovieResultModel] = []
    private var myDict : [MovieResultModel] = []
    private var idService = [Int]()
    private let tableView = UITableView()
    private let coreDataServices = CoreDataServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewEdit()
        configure()
        getCoreData()
        control()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        idService = CoreDataServices().completionCoreData()
        control()
        tableView.reloadData()
    }
    
    func viewEdit() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoritesTableViewCell.nib, forCellReuseIdentifier: FavoritesTableViewCell.identifier)
    }
    
    func configure() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func getCoreData() {
        coreDataServices.getJson { result in
            switch result{
            case .success(let data):
                self.movieDict = data
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func control() {
        myDict.removeAll()
        for index in idService.reversed() {
            for movieIndex in 0...movieDict.count - 1 {
                if index == movieDict[movieIndex].id {
                    myDict.append(movieDict[movieIndex])
                }
            }
        }
    }
}
extension FavoritesVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier, for: indexPath) as? FavoritesTableViewCell else{
            fatalError()
        }
        cell.movieTitle.text = myDict[indexPath.row].original_title
        cell.movieOverview.text = myDict[indexPath.row].overview
        cell.configure()
        cell.cellEdit()
        DispatchQueue.main.async {
            cell.moviePoster.setImageWithKF(url: imagaBaseUrl + self.myDict[indexPath.row].poster_path, size: cell.moviePoster.bounds.size)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenHeight * 0.2
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            CoreDataServices().removeFavorites(id: myDict[indexPath.row].id)
            myDict.remove(at: indexPath.row)
            idService.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goDetails(index: indexPath.row)
    }
    
    func goDetails(index : Int) {
        let vc = DetailsVC()
        vc.detailsTitle.text  = myDict[index].original_title
        vc.detailsOverview.text = myDict[index].overview
        vc.imageUrl = imagaBaseUrl + myDict[index].poster_path
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
