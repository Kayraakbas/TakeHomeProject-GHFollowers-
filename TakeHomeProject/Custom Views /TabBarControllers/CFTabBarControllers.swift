//
//  CFTabBarControlles.swift
//  TakeHomeProject
//
//  Created by Kayra Akbaş on 24.09.2024.
//

import UIKit

class CFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(), createFavoritesNC()]
   
    }
    
    
    func createSearchNC() -> UINavigationController{
        
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoritesNC() -> UINavigationController{
        
        let favoritesVC = FavoritesListVC()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        return UINavigationController(rootViewController: favoritesVC)
    }

}
