//
//  Global.swift
//  NewsApp
//
//  Created by lapshop on 2/1/22.
//

import Foundation

enum CustomErrorModel : Error {
    case badRequest
    case noData
    case errorDecodingResponse
}

extension CustomErrorModel : CustomStringConvertible {
    
    var description: String {
        switch  self {
        case .badRequest:
            return  "bad request"
        case .noData:
            return "no data to be fetched"
        case .errorDecodingResponse:
            return "couldnot decode the response"
        }
    }
}



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



enum QueryManager {
    static let NEWS_TABLE_NAME = "NEWS"
    
    case createTableQuery
    case insertIntoNewsTable
    case selectAllArticlesFromNewsTable
    case selectArticleFromNewsTable(dateString:String)
    
    var query : String {
        switch self {
          case .createTableQuery:
            return """
                create table \(QueryManager.NEWS_TABLE_NAME)
                (ID integer primary key autoincrement not null,
                TITLE text not null,
                CONTENT text,
                SOURCE text,
                IMAGEURL text,
                PUBLISHEDAT text not null,
                AUTHOR text);
                """
            
          case .insertIntoNewsTable:
            return """
                insert into \(QueryManager.NEWS_TABLE_NAME) (TITLE, CONTENT, SOURCE,IMAGEURL,PUBLISHEDAT,AUTHOR) values (?, ?, ?, ? , ?, ?);
                """
            
          case .selectAllArticlesFromNewsTable:
                return """
                select * from \(QueryManager.NEWS_TABLE_NAME) ;"
                """
                
          case .selectArticleFromNewsTable(let dateString):
                return """
                select * from \(QueryManager.NEWS_TABLE_NAME) where PUBLISHEDAT = '\(dateString)';"
                """
        }
    }
}
