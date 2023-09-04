//
//  TMDBTabBarViewController.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/09/04.
//

import UIKit

class TMDBTabBarViewController: UITabBarController {
    
    let appDIContainer = AppDIContainer()
    let subControllerIdentifier: [String] = ["TrnedList","TVSeries","MapView","ProfileView"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        let navs = viewControllers?.map({ vc in
            let nav = UINavigationController(rootViewController: vc)
            return nav
        })
        super.setViewControllers(navs, animated: animated)
    }
    
    

}
