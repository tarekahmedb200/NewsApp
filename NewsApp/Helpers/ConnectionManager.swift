//
//  ConnectionManager.swift
//  NewsApp
//
//  Created by lapshop on 2/2/22.
//

import Foundation
import Network

class ConnectionManager {
    private let monitor = NWPathMonitor()
    
    func checkConnection(completion:@escaping (_ isConnected:Bool) -> Void) {
        monitor.pathUpdateHandler = { path in
            switch  path.status {
            case .satisfied:
                completion(true)
            default:
                completion(false)
            }
        }
        monitor.start(queue: DispatchQueue.main)
    }
    
}
