//
//  ViewController.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/20.
//

import UIKit

class MasterTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
       
    
        setUpTabs()
    }
    
    func setUpTabs(){
        let characterVC = CharacterViewController()
        let locationVC = LocationViewController()
        let episodeVC = EpisodeViewController()
        let settingsVC = SettingsViewController()
        
        characterVC.navigationItem.largeTitleDisplayMode = .automatic
        locationVC.navigationItem.largeTitleDisplayMode = .automatic
        episodeVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: characterVC)
        let nav2 = UINavigationController(rootViewController: locationVC)
        let nav3 = UINavigationController(rootViewController: episodeVC)
        let nav4 = UINavigationController(rootViewController: settingsVC)
        
        nav1.tabBarItem = UITabBarItem(title: "角色",
                                       image: UIImage(systemName: "persion"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "位置",
                                       image: UIImage(systemName: "globe"),
                                       tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "事件",
                                       image: UIImage(systemName: "tv"),
                                       tag: 1)
        nav4.tabBarItem = UITabBarItem(title: "設定",
                                       image: UIImage(systemName: "gear"),
                                       tag: 1)
        
        for nav in[nav1, nav2, nav3, nav4]{
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([nav1, nav2, nav3, nav4],
                           animated: true)
        
    }


}

