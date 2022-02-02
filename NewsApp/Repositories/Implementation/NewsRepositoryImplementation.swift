//
//  NewsRepositoryImplementation.swift
//  NewsApp
//
//  Created by lapshop on 2/1/22.
//

import Foundation


class NewsRepositoryImplementation : NewsRepository {
        
    let remoteApi : RemoteApi

    
    init(remoteApi:RemoteApi) {
        self.remoteApi = remoteApi
    }
    
    func getArticles(with endPoint: EndPoint, completion: @escaping (Result<[Article], CustomErrorModel>) -> Void) {
        remoteApi.getNews(with: endPoint) { (result) in
            switch result {
                case .success(let articles):
                    completion(.success(articles))
                case .failure(let customErrorModel):
                    completion(.failure(customErrorModel))
            }
        }
    }
}
