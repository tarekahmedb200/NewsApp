//
//  NewApi.swift
//  NewsApp
//
//  Created by lapshop on 2/1/22.
//

import Foundation

class NewApi : RemoteApi {
    func getNews(with endPoint: EndPoint, completion: @escaping (Result<[Article], CustomErrorModel>) -> Void) {
        guard let url = endPoint.url else {
                return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
              
            guard  error == nil else {
                completion(.failure(.badRequest))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            let jsonDecode = JSONDecoder()
                        
            do {
                let responseData = try jsonDecode.decode(Response.self, from: data)
                completion(.success(responseData.articles))
            }catch {
                print(error)
                print(error.localizedDescription)
                completion(.failure(.errorDecodingResponse))
            }
        }.resume()
        
    }
    
}
