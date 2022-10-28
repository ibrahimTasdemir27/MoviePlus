//
//  TabBarController.swift
//  MoviePlus
//
//  Created by İbrahim Taşdemir on 26.10.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let homePage = UINavigationController(rootViewController: HomePageVC())
        let favoritesPage = FavoritesVC()
        let profilePage = ProfileVC()

        homePage.title = "Home"
        favoritesPage.title = "Favorites"
        profilePage.title = "Profile"
        
        self.setViewControllers([homePage,favoritesPage,profilePage], animated: true)
        
        guard let items = tabBar.items else{
            return
        }
        for i in 0...Icons.allCases.count - 1 {
            items[i].image = Icons.allCases[i].imageName
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.tintColor = primaryColor
    }

}
