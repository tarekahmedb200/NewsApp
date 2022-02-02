//
//  String+Extensions.swift
//  NewsApp
//
//  Created by lapshop on 2/2/22.
//

import Foundation

extension String {
    
    
    func transformStringDate(fromDateFormat  : DateFormat ,
                             toDateFormat : DateFormat ) -> String? {

        let initalFormatter = DateFormatter()
        initalFormatter.dateFormat = fromDateFormat.rawValue

        guard let initialDate = initalFormatter.date(from: self) else {
            print ("Error in dateString or in fromDateFormat")
            return nil
        }

        let resultFormatter = DateFormatter()
        resultFormatter.dateFormat = toDateFormat.rawValue

        return resultFormatter.string(from: initialDate)
    }
    
    
}

