//
//  UIUtitles.swift
//  NewsApp
//
//  Created by lapshop on 2/2/22.
//

import UIKit

class UIUtitles {
    
    static let shared = UIUtitles()
    

    private init() {}
    
    
    func showAlertMessage(title:String,message:String,_ viewController:UIViewController) {
        let alertController  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    
    func createActivityIndicator(_ viewController:UIViewController) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = UIColor.white
        activityIndicator.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.frame = viewController.view.frame
        viewController.view.addSubview(activityIndicator)
        activityIndicator.style = .large
        return activityIndicator
    }
    
}
