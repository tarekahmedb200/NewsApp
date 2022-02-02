////
////  HomeViewModel.swift
////  NewsApp
////
////  Created by lapshop on 2/1/22.
////
//
import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    private var page = 1
    var articleArray : [Article] = []
    private var viewState = BehaviorRelay<State>(value: .gettingData)
    var stateObservable : Driver<State>   {
        return viewState.asDriver()
    }
    private var newsRepository : NewsRepository
    private var homeCoordinator : HomeCoordinatorProtocol
    
    
    enum State {
        case gettingData
        case noresults
        case loadingData
    }

    enum Action {
        case scrollForMore
        case clickCell(article:Article)
    }


    init(newsRepository : NewsRepository,homeCoordinator:HomeCoordinatorProtocol) {
        self.newsRepository = newsRepository
        self.homeCoordinator  = homeCoordinator
        getArticles()
    }

    func getArticles() {
        self.newsRepository.getArticles(with: .getArticles(offset: page)) { [weak self] (result) in
            guard let weakself = self else {return}
            switch result {
               case .success(let articlesArray):
                weakself.page += articlesArray.count > 0 ? 1 : 0
                weakself.articleArray.append(contentsOf: articlesArray)
                
                weakself.viewState.accept(.loadingData)
               case .failure(let customErrorModel):
                print(customErrorModel.description)
            }
        }
    }

   func onAction(action:Action)  {
    switch action {
    case .scrollForMore:
        viewState.accept(.gettingData)
        getArticles()
    case .clickCell(let article):
        homeCoordinator.navigateToArticleDetailsViewController(article)
    }
   }
}

