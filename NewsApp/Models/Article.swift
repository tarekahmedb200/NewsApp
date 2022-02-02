//
//  Article.swift
//  NewsApp
//
//  Created by lapshop on 2/1/22.
//

import Foundation


struct Article : Codable {
    
    
    var title: String
    var content: String?
    var imageUrl : String?
    var publishedAt: String
    var source : ArticleSource
    var author : String?
    enum CodingKeys : String , CodingKey {
        case source = "source"
        case author
        case title
        case imageUrl = "urlToImage"
        case publishedAt
        case content
        
    }
}
