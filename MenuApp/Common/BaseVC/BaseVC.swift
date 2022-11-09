//
//  BaseVC.swift
//  MenuApp
//
//  Created by Milos Petrusic on 9.11.22..
//

import UIKit

class BaseVC: UIViewController {
    
    private var activityIndicator: ActivityIndicator?
    
    internal func startActivityIndicator() {
        activityIndicator = ActivityIndicator(frame: self.view.frame)
        if let activityIndicator = activityIndicator {
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
    }
    
    internal func stopActivityIndicator() {
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
    }
}
