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
        tabBar.setViewControllers([makeTrendListViewController(), makeTVSeriesViewController()], animated: true)
        return tabBar
    }
    
    func makeTrendListViewController() -> TrendListViewController {
        return TrendListViewController(repository: appDIContainer.tmdbRepository)
    }
    
    func makeTVSeriesViewController() -> TVSeriesViewController {
        let tv = TVSeriesViewController()
        tv.repository = appDIContainer.tmdbRepository
        return tv
    }
}
