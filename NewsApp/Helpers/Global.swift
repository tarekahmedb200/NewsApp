//
//  Global.swift
//  NewsApp
//
//  Created by lapshop on 2/1/22.
//

import Foundation


struct APISettings {
    static let apiKey = "0638324173d04b6495cb33442be5d4d3"
}


enum EndPoint  {
    static let baseUrl = "https://newsapi.org/v2"
    static let apiKeyParameter = "?apiKey="
    static let offsetParameter = "&page="
    static let countryParameter = "&country="
    
    case getArticles(offset:Int)
    case getAllArticles
    
    var url : URL? {
        if let url = URL(string:self.stringUrl) {
            return url
        }
        return nil
    }
    
    var stringUrl : String {
        switch self {
            case .getArticles(let offset):
                return EndPoint.baseUrl + "/top-headlines" + EndPoint.apiKeyParameter + APISettings.apiKey + EndPoint.offsetParameter + "\(offset)" + EndPoint.countryParameter + "us"
                
        case .getAllArticles:
            return EndPoint.baseUrl + "/top-headlines" + EndPoint.apiKeyParameter + APISettings.apiKey + EndPoint.countryParameter + "us"
        }
    }
}


enum DateFormat : String {
    case yearWithDate = "MM/dd/yyyy HH:mm"
    case fullDate = "yyyy-MM-dd'T'HH:mm:ssZ"
}
