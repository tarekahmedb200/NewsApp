//
//  CustomError.swift
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
