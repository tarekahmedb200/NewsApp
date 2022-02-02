//
//  NewsRepositoryImplementation.swift
//  NewsApp
//
//  Created by lapshop on 2/1/22.
//

import Foundation


class NewsRepositoryImplementation : NewsRepository {
    
    let remoteApi : RemoteApi
    let newDataStore : NewsDataStoreProtocol

    init(remoteApi:RemoteApi,newsDataStore:NewsDataStoreProtocol) {
        self.remoteApi = remoteApi
        self.newDataStore = newsDataStore
    }
    
    func getArticlesRemotley(with endPoint: EndPoint, completion: @escaping (Result<[Article], CustomErrorModel>) -> Void) {
            
        remoteApi.getNews(with: endPoint) { [weak self] (result) in
            guard let weakself = self else {return}
            switch result {
            case .success(let articles):
                weakself.newDataStore.save(articles)
                completion(.success(articles))
            case .failure(let customErrorModel):
                completion(.failure(customErrorModel))
            }
        }
    }
    
    func getArticlesOffline(completion: @escaping (Result<[Article], CustomErrorModel>) -> Void) {
        self.newDataStore.getArticles { (result) in
            switch result {
            case .success(let articles):
                completion(.success(articles))
            case .failure(let customErrorModel):
                completion(.failure(customErrorModel))
            }
         }
    }
}
