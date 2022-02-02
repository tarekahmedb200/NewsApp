//
//  NewsDataStoreProtocol.swift
//  NewsApp
//
//  Created by lapshop on 2/2/22.
//

import Foundation


protocol NewsDataStoreProtocol : class {
    func save(_ articles:[Article])
    func getArticles(completion:@escaping (Result<[Article],CustomErrorModel>) -> Void)
}
