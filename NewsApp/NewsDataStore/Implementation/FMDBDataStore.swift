//
//  FMDBDataStore.swift
//  NewsApp
//
//  Created by lapshop on 2/2/22.
//

import Foundation
import FMDB


class FMDBDataStore : NewsDataStoreProtocol {
    
    let databaseFileName = "NEWS_DATABASE.sqlite"
    var pathToDatabase: String!
    var database: FMDatabase!
    var resultSet : FMResultSet!
    
    init() {
        createDatabase()
    }
    
    private func createDatabase() {
        let dbPath = getPath()
        if !FileManager.default.fileExists(atPath: dbPath) {
            database = FMDatabase(path: dbPath)
            createNewsTable()
        }
    }
    
    private func getPath() -> String {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = documentDirectory.appendingPathComponent(databaseFileName)
        return fileUrl.path
    }
    
    
    private func createNewsTable() {
        if isDatabaseOpen() {
            do {
                try database.executeUpdate(QueryManager.createTableQuery.query, values: nil)
               }
               catch {
                   print("Could not create table.")
                   print(error.localizedDescription)
               }

               database.close()
        }
    }
    
    
    private func isDatabaseOpen() -> Bool {
        if database == nil {
            let dbPath = getPath()
            if FileManager.default.fileExists(atPath: dbPath) {
                database = FMDatabase(path: dbPath)
            }
        }
     
        if database != nil {
            if database.open() {
                return true
            }
        }
        return false
    }
    
    
    func save(_ articles: [Article]) {
        
        guard  isDatabaseOpen() else {
            print("database not open")
            return
        }
        
        do {
            try articles.forEach {
                if ifArticleExist(with: $0) == false {
                    try database.executeUpdate(QueryManager.insertIntoNewsTable.query, values: [$0.title,$0.content ?? "",$0.source,$0.imageUrl ?? "",$0.publishedAt,$0.author ?? ""])
                }
            }
        } catch let  error {
            print(error.localizedDescription)
        }
        
        database.close()
    }
    
    func getArticles(completion:@escaping (Result<[Article],CustomErrorModel>) -> Void) {
        var articles = [Article]()
        
        guard  isDatabaseOpen() else {
            print("database not open")
            return
        }
        
        do {
            resultSet = try database.executeQuery(QueryManager.selectAllArticlesFromNewsTable.query, values: nil)
            
            while resultSet.next() {
                let article = getResultSet()
                articles.append(article)
            }
            completion(.success(articles))
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        database.close()
    }
    
    
    
    private func ifArticleExist(with article:Article) -> Bool {
        var fetchedArticle : Article?
        guard  isDatabaseOpen() else {
            print("database not open")
            return false
        }
        
        do {
            resultSet = try database.executeQuery(QueryManager.selectArticleFromNewsTable(dateString: article.publishedAt).query, values: nil)
            
            while resultSet.next() {
                 fetchedArticle = getResultSet()
            }
           
            if let fetchedArticle = fetchedArticle , fetchedArticle.publishedAt == article.publishedAt {
                return true
            }
            
            return false
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        return false
    }
    
    
    private func getResultSet() -> Article {
         let title = resultSet.string(forColumn: "TITLE") ?? ""
         let content = resultSet.string(forColumn: "CONTENT")
         let imageUrl  = resultSet.string(forColumn: "IMAGEURL")
         let publishedAt = resultSet.string(forColumn: "PUBLISHEDAT") ?? ""
         let source = resultSet.string(forColumn: "SOURCE") ?? nil
         let author = resultSet.string(forColumn: "AUTHOR")
       
         return Article(title: title, content: content, imageUrl: imageUrl, publishedAt: publishedAt, source: ArticleSource(name:source), author: author)
    }
    
    
}
