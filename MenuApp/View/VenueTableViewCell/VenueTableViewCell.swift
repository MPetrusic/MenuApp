//
//  VenueTableViewCell.swift
//  MenuApp
//
//  Created by Milos Petrusic on 7.11.22..
//

import UIKit

class VenueTableViewCell: UITableViewCell, NibProtocol {

    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var venueDistanceLabel: UILabel!
    @IBOutlet weak var venueAddressLabel: UILabel!
    @IBOutlet weak var venueOpenHoursLabel: UILabel!
    
    var venue: Venue? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func updateUI() {
        guard let venue else { return }
        
        venueNameLabel.text = venue.venue?.name
        venueDistanceLabel.text = venue.distanceInKilometers
        venueAddressLabel.text = venue.venue?.address
        venueOpenHoursLabel.text = venue.venue?.servingTimes?[0].servingTime
    }
    
}
