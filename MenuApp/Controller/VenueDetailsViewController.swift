//
//  VenueDetailsViewController.swift
//  MenuApp
//
//  Created by Milos Petrusic on 8.11.22..
//

import Kingfisher
import UIKit

class VenueDetailsViewController: UIViewController {

    @IBOutlet weak var venueImageView: UIImageView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var venueWelcomeMessageLabel: UILabel!
    @IBOutlet weak var venueDescriptionLabel: UILabel!
    @IBOutlet weak var venueIsOpenView: UIView!
    @IBOutlet weak var venueIsOpenLabel: UILabel!
    
    var venueDetails: VenueDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        logoutButton.layer.cornerRadius = logoutButton.frame.size.height / 2
        venueIsOpenView.layer.cornerRadius = 2
        
        guard let venueDetails else { return }
        
        let venueImage = venueDetails.image?.thumbnailMedium ?? ""
        let venueImageURL = URL(string: venueImage)
        
        venueImageView.kf.setImage(with: venueImageURL)
        venueNameLabel.text = venueDetails.name
        venueWelcomeMessageLabel.text = venueDetails.welcomeMessage
        venueDescriptionLabel.text = venueDetails.description
        
        if let isOpen = venueDetails.isOpen {
            venueIsOpenView.backgroundColor = isOpen ? Colors.menuOrange.color() : .gray
            venueIsOpenLabel.text = isOpen ? "Open".uppercased() : "Currently Closed".uppercased()
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        LocalStorage.deleteLoginData()
        let storyboard = UIStoryboard(name: Storyboards.login.rawValue, bundle: nil)
        let venuesVC = storyboard.instantiateViewController(withIdentifier: ViewControllerIDs.loginVC.rawValue)
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(venuesVC, options: .transitionFlipFromRight)
    }
}
