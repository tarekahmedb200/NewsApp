//
//  Coordinator.swift
//  NewsApp
//
//  Created by lapshop on 2/1/22.
//

import UIKit

protocol Coordinator {
    var navigationController : UINavigationController {set get}
    
    func start()
}
