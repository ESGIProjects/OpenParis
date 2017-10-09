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
		
		let logementCoordinate = CLLocationCoordinate2D(latitude: logement.latitude, longitude: logement.longitude)
		
		// Original map region
		let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
		var region = MKCoordinateRegion(center: logementCoordinate, span: span)
		region = mapView.regionThatFits(region)
		mapView.setRegion(region, animated: true)
		
		// delete every pin on the map (precaution)
		mapView.removeAnnotations(mapView.annotations)
		
		// Add logement to the map
		let logementAnnotation = MKPointAnnotation()
		logementAnnotation.coordinate = logementCoordinate
		logementAnnotation.title = logement.name
		logementAnnotation.subtitle = "\(logement.price) €"
		mapView.addAnnotation(logementAnnotation)
		
		// Adding every places to the map
		for place in logement.places {
			let coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
			let annotation = MKPointAnnotation()
			annotation.coordinate = coordinate
			annotation.title = place.name
			annotation.subtitle = "\(place.categorie)"
			mapView.addAnnotation(annotation)
		}
	}
}

// MARK: - MKMapViewDelegate
extension LogementViewController : MKMapViewDelegate {
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		if annotation is MKUserLocation { return nil }
				
		var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "LogementAnnotation") as? MKPinAnnotationView
		
		if annotationView == nil {
			let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "LogementAnnotation")
			pinAnnotationView.canShowCallout = true
			if let title = annotation.title {
				pinAnnotationView.pinTintColor = (title == logement.name) ? .green : .red
			}
			else {
				pinAnnotationView.pinTintColor = .red
			}
			annotationView = pinAnnotationView
		}
		else {
			annotationView?.annotation = annotation
		}
		
		
		
		return annotationView
	}
}
