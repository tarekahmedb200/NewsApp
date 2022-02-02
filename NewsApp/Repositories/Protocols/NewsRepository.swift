//
//  NewsRepository.swift
//  NewsApp
//
//  Created by lapshop on 2/1/22.
//

import Foundation


protocol NewsRepository {
    func getArticlesRemotley(with endPoint : EndPoint,completion:@escaping (Result<[Article],CustomErrorModel>) -> Void)
    
    func getArticlesOffline(completion:@escaping (Result<[Article],CustomErrorModel>) -> Void)
}
