//
//  TabBarViewController.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2022/02/08.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .customBlue
        tabBar.unselectedItemTintColor = .customBlack
        tabBar.backgroundColor = .customWhite
        
        let ListVC = UINavigationController(rootViewController: ListViewController())
        ListVC.tabBarItem.image = UIImage(systemName: "list.dash")
        ListVC.tabBarItem.title = "목록"
        
        let SearchVC = UINavigationController(rootViewController: SearchViewController())
        SearchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        SearchVC.tabBarItem.title = "검색"
        
        let MapVC = UINavigationController(rootViewController: MapViewController())
        MapVC.tabBarItem.image = UIImage(systemName: "map")
        MapVC.tabBarItem.title = "기록"
        
        let ListUpVC = UINavigationController(rootViewController: ListUpViewController())
        ListUpVC.tabBarItem.image = UIImage(systemName: "person")
        ListUpVC.tabBarItem.title = "지도"
        
        viewControllers = [ListVC, SearchVC, MapVC, ListUpVC]
        
    }
}
