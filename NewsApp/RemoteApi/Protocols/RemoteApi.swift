//
//  RemoteApi.swift
//  NewsApp
//
//  Created by lapshop on 2/1/22.
//

import Foundation


protocol RemoteApi : class {
    func getNews(with endPoint : EndPoint,completion:@escaping (Result<[Article],CustomErrorModel>) -> Void)
}
