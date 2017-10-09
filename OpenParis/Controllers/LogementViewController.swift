//
//  LogementViewController.swift
//  OpenParis
//
//  Created by Jason Pierna on 09/10/2017.
//  Copyright © 2017 ESGI. All rights reserved.
//

import UIKit
import MapKit
import SafariServices

class LogementViewController: UIViewController {

	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var minimumNightsLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	@IBOutlet weak var neighborhoodLabel: UILabel!
	
	var logement: Logement!
	
	// MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

		updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: - IBActions
	
	@IBAction func showOnAirBnb(_ sender: UIButton) {
		if let url = URL(string: "https://www.airbnb.fr/rooms/\(logement.id)") {
			let safariViewController = SFSafariViewController(url: url)
			present(safariViewController, animated: true)
		}
		else {
			let alert = UIAlertController(title: "Not available", message: "The link for this appartment is not available", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default))
			
			present(alert, animated: true)
		}
	}
	
	// MARK: - Helpers
	
	func updateUI() {
		nameLabel.text = logement.name
		minimumNightsLabel.text = "Minimum nights: \(logement.minimumNights)"
		priceLabel.text = "\(logement.price) €/night"
		neighborhoodLabel.text = "\(logement.neighborhood)"
	}
}
