//
//  ViewController.swift
//  MenuApp
//
//  Created by Milos Petrusic on 7.11.22..
//

import UIKit

class VenuesViewController: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    private let latitude = "44.001783"
    private let longitude = "21.26907"
    
    private(set) var venueService: VenueServiceProvider?
    private var venues: [Venue]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupService()
        registerCells()
        setupTableView()
        loadVenues()
    }
    
    private func setupService() {
        if venueService == nil {
            setVenueService(VenuesService())
        }
    }
    
    func setVenueService(_ service: VenueServiceProvider) {
        venueService = service
    }
    
    private func loadVenues() {
        startActivityIndicator()
        venueService?.getVenues(latitude: latitude, longitude: longitude) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.stopActivityIndicator()
            }
            switch result {
            case .success(let venuesData):
                self.venues = venuesData.venues
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.fetchingVenuesFailure()
                }
            }
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func registerCells() {
        tableView.register(VenueTableViewCell.nib, forCellReuseIdentifier: VenueTableViewCell.identifier)
    }
    
    private func fetchingVenuesFailure() {
        let ac = UIAlertController(title: "Fetching failed", message: "Please try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Reload", style: .default, handler: { _ in
            self.loadVenues()
        }))
        present(ac, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension VenuesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: VenueTableViewCell.identifier, for: indexPath) as? VenueTableViewCell {
            cell.venue = venues?[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension VenuesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let venueDetailsVC = storyboard?.instantiateViewController(withIdentifier: ViewControllerIDs.venueDetailsVC.rawValue) as? VenueDetailsViewController {
            venueDetailsVC.venueDetails = venues?[indexPath.row].venue
            navigationController?.pushViewController(venueDetailsVC, animated: true)
        }
    }
}

