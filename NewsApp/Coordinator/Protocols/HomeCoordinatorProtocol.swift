//
//  HomeCoordinator.swift
//  NewsApp
//
//  Created by lapshop on 2/2/22.
//

import Foundation


protocol HomeCoordinatorProtocol : CoordinatorProtocol {
    func navigateToArticleDetailsViewController(_ article:Article)
}
