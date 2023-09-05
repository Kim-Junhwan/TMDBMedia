//
//  SceneDIContainer.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/09/04.
//

import Foundation
import UIKit

final class SceneDIContainer {
    
    let appDIContainer: AppDIContainer
    
    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
    }
    
    func makeTabBarController() -> TMDBTabBarViewController {
        let tabBar = TMDBTabBarViewController()
        tabBar.setViewControllers([makeTrendListViewController(), makeTVSeriesViewController(), makeMapViewController(), makeProfilieViewController()], animated: true)
        return tabBar
    }
    
    func makeTrendListViewController() -> TrendListViewController {
        let vc = TrendListViewController(repository: appDIContainer.tmdbRepository)
        vc.tabBarItem = .init(title: "Trend List", image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet"))
        return vc
    }
    
    func makeTVSeriesViewController() -> TVSeriesViewController {
        let tv = TVSeriesViewController(repository: appDIContainer.tmdbRepository)
        tv.tabBarItem = .init(title: "TVSeries", image: UIImage(systemName: "tv"), selectedImage: UIImage(systemName: "tv"))
        return tv
    }
    
    func makeMapViewController() -> MapViewController {
        let mapView = MapViewController()
        mapView.tabBarItem = .init(title: "Map", image: UIImage(systemName: "map.fill"), selectedImage: UIImage(systemName: "map.fill"))
        return mapView
    }
    
    func makeProfilieViewController() -> ProfileViewController {
        let profileView = ProfileViewController()
        profileView.tabBarItem = .init(title: "Profile", image: UIImage(systemName: "person.fill"), selectedImage: UIImage(systemName: "person.fill"))
        return profileView
    }
}
