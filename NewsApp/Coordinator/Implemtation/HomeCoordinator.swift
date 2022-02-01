//
//  HomeCoordinator.swift
//  NewsApp
//
//  Created by lapshop on 2/1/22.
//

import UIKit


class HomeCoordinator : Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeViewModel = getHomeViewModel()
        guard let homeViewController = HomeViewController.instantiate(with: homeViewModel)
            else {
                return
            }
        self.navigationController.pushViewController(homeViewController, animated: true)
    }
    
    private func getHomeViewModel() -> HomeViewModel{
        return HomeViewModel()
    }
}
