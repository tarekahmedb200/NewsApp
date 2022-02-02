//
//  HomeCoordinator.swift
//  NewsApp
//
//  Created by lapshop on 2/1/22.
//

import UIKit


class HomeCoordinator : HomeCoordinatorProtocol {
    
    
    var navigationController: UINavigationController
    var newsRepository : NewsRepository
    
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
        
        func getNewsRepository() -> NewsRepository {
            let remoteApi = getRemotApi()
            let newDataStore = getNewDataStore()
            let newsRepositoryImplementation = NewsRepositoryImplementation(remoteApi: remoteApi,newsDataStore: newDataStore)
            return newsRepositoryImplementation
        }
        
        func getRemotApi() -> RemoteApi {
            let remoteApi = NewApi()
            return remoteApi
        }
        
        func getNewDataStore() -> NewsDataStoreProtocol {
            let newsDataStore = FMDBDataStore()
            return newsDataStore
        }
        
        self.newsRepository = getNewsRepository()
    }
    
    func start() {
        let homeViewModel = getHomeViewModel()
        guard let homeViewController = HomeViewController.instantiate(with: homeViewModel)
            else {
                return
            }
        self.navigationController.pushViewController(homeViewController, animated: true)
    }
    
    private func getHomeViewModel() -> HomeViewModel {
        let homeViewModel = HomeViewModel(newsRepository: newsRepository, homeCoordinator: self)
        return homeViewModel
    }
    
    func navigateToArticleDetailsViewController(_ article: Article) {
        let atricleDetailsCoordinator = ArticleDetailsCoordinator(navigationController: self.navigationController, newsRepository: newsRepository, article: article)
        atricleDetailsCoordinator.start()
    }

}
