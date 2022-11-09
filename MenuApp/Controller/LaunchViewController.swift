//
//  LaunchViewController.swift
//  MenuApp
//
//  Created by Milos Petrusic on 7.11.22..
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if LocalStorage.isUserLoggedIn {
            goToVenues()
        } else {
            goToLogin()
        }
    }
    
    private func goToVenues() {
        let storyboard = UIStoryboard(name: Storyboards.venues.rawValue, bundle: nil)
        let venuesVC = storyboard.instantiateViewController(withIdentifier: ViewControllerIDs.venuesNav.rawValue)
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(venuesVC, options: .transitionFlipFromRight)
    }
    
    private func goToLogin() {
        let storyboard = UIStoryboard(name: Storyboards.login.rawValue, bundle: nil)
        let venuesVC = storyboard.instantiateViewController(withIdentifier: ViewControllerIDs.loginVC.rawValue)
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(venuesVC, options: .transitionFlipFromRight)
    }
}
