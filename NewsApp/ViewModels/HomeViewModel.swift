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
    var connectionanager = ConnectionManager()
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
        case showErrorMessage(errorMessage:String)
        case showOfflineModeView
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
        connectionanager.checkConnection { [weak self] (isConnected) in
            guard let weakself = self else {return}
            if isConnected {
                weakself.getArticlesRemotley()
            }else {
                weakself.getArticlesOffline()
            }
        }
    }
    
    private func getArticlesRemotley() {
        self.newsRepository.getArticlesRemotley(with: .getArticles(offset: page)) { [weak self] (result) in
            guard let weakself = self else {return}
            switch result {
               case .success(let articlesArray):
                if articlesArray.count == 0 && weakself.page == 0 {
                    weakself.viewState.accept(.noresults)
                }else {
                    weakself.page +=  1
                    weakself.articleArray.append(contentsOf: articlesArray)
                    weakself.viewState.accept(.loadingData)
                }
               case .failure(let customErrorModel):
                weakself.viewState.accept(.showErrorMessage(errorMessage: customErrorModel.description))
            }
        }
    }
    
    private func getArticlesOffline() {
        self.newsRepository.getArticlesOffline {  [weak self] (result) in
            guard let weakself = self else {return}
            switch result {
               case .success(let articlesArray):
                if articlesArray.count == 0 {
                    weakself.viewState.accept(.noresults)
                }else {
                    weakself.articleArray.append(contentsOf: articlesArray)
                    weakself.viewState.accept(.showOfflineModeView)
                    weakself.viewState.accept(.loadingData)
                }
               case .failure(let customErrorModel):
                weakself.viewState.accept(.showErrorMessage(errorMessage: customErrorModel.description))
            }
        }
    }
    
   func onAction(action:Action)  {
    switch action {
    case .scrollForMore:
        connectionanager.checkConnection { [weak self] (isConncted) in
            guard let weakself = self else { return }
            if isConncted {
                weakself.viewState.accept(.gettingData)
                weakself.getArticlesRemotley()
            }
        }
    case .clickCell(let article):
        homeCoordinator.navigateToArticleDetailsViewController(article)
    }
   }
}

