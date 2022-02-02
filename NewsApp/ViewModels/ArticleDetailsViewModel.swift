//
//  ArticleDetailsViewModel.swift
//  NewsApp
//
//  Created by lapshop on 2/2/22.
//

import Foundation
import RxSwift
import RxCocoa

class ArticleDetailsViewModel  {
    
    var article : Article
    var NewsRepository : NewsRepository
    var stateObservable : Driver<State>   {
        return viewState.asDriver()
    }

    var articleImageUrl : URL? {
        guard let imageStringUrl = article.imageUrl , let imageUrl = URL(string:imageStringUrl) else {
              return nil
        }
        return imageUrl
    }
    
    var articleDateString : String {
        guard let articleDateString = article.publishedAt.transformStringDate(fromDateFormat: .fullDate, toDateFormat: .yearWithDate) else {
              return "No Date Avilable"
        }
        return "Published At : \(articleDateString)"
    }
    
    var articleTitle : String {
        return article.title
    }
    
    var articleSourceName : String {
        return "Source : \(article.source.name)"
    }
    
    var articleAuthorName : String {
        guard let authorName =  article.author else {
            return "No Author Name Available"
        }
        return "Author : \(authorName)"
    }
    
    
    var articleContent : String {
        guard let authorName =  article.content else {
            return "No Content Available"
        }
        return authorName
    }
    
    
    private var viewState = BehaviorRelay<State>(value: .gettingData)
    
    init(article:Article,newsRepository : NewsRepository) {
        self.article = article
        self.NewsRepository = newsRepository
        viewState.accept(.loadingData)
    }
   
    enum State {
        case gettingData
        case loadingData
    }

    enum Action {
        case clickButton(rate:Int)
    }

    
   func onAction(action:Action)  {
    switch action {
        case .clickButton(let rate):
            print(rate)
    }
   }
}
