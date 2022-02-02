//
//  ArticleDetailsCoordinator.swift
//  NewsApp
//
//  Created by lapshop on 2/2/22.
//

import UIKit

class ArticleDetailsCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var newsRepository : NewsRepository
    var article : Article
    
    
    init(navigationController:UINavigationController,newsRepository:NewsRepository,article:Article) {
        self.navigationController = navigationController
        self.newsRepository = newsRepository
        self.article = article
    }
    
    func start() {
        let articleDetailsViewModel = makeArticleDetailsViewModel()
        guard let  atricleDetailsDetailsViewController = ArticleDetailsViewController.instantiate(with: articleDetailsViewModel) else {
            return
        }
        navigationController.pushViewController(atricleDetailsDetailsViewController, animated: false)
    }
    
    private func makeArticleDetailsViewModel() -> ArticleDetailsViewModel {
        return ArticleDetailsViewModel(article: self.article, newsRepository: self.newsRepository)
    }
    
    
    
    
}
