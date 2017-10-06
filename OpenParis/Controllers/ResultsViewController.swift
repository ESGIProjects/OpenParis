//
//  ListViewController.swift
//  OpenParis
//
//  Created by Kévin Le on 07/09/2017.
//  Copyright © 2017 ESGI. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON

class ResultsViewController : UIViewController {
	
	@IBOutlet var mapView: MKMapView!
	@IBOutlet var tableView: UITableView!
	
	var logements: [Logement]!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.register(UINib(nibName: "LogementCell", bundle: nil), forCellReuseIdentifier: "LogementCell")
		
		// Original map region
		let center = CLLocationCoordinate2D(latitude: logements[0].latitude, longitude: logements[0].longitude)
		let span = MKCoordinateSpan(latitudeDelta: 0.027, longitudeDelta: 0.027)
		var region = MKCoordinateRegion(center: center, span: span)
		region = mapView.regionThatFits(region)
		mapView.setRegion(region, animated: true)

		// Adding every logements to the map
		for logement in logements {
			let coordinate = CLLocationCoordinate2D(latitude: logement.latitude, longitude: logement.longitude)
			let annotation = MKPointAnnotation()
			annotation.coordinate = coordinate
			annotation.title = logement.name
			mapView.addAnnotation(annotation)
		}
	}
}

extension ResultsViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return logements.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "LogementCell", for: indexPath) as? LogementCell else {
			return UITableViewCell(style: .default, reuseIdentifier: "LogementCell")
		}
		
		let logement = logements[indexPath.row]
		
		cell.nameLabel.text = logement.name
		
		let formatter = NumberFormatter()
		formatter.currencySymbol = "€"
		formatter.numberStyle = .currency
		
		cell.priceLabel.text = "\(formatter.string(from: NSNumber(integerLiteral: logement.price))!)/nights"
		
		return cell
	}
}

extension ResultsViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension ResultsViewController : MKMapViewDelegate {
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		if annotation is MKUserLocation { return nil }
		
		var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "LogementAnnotation")
		
		if annotationView == nil {
			let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "LogementAnnotation")
			pinAnnotationView.canShowCallout = true
			pinAnnotationView.pinTintColor = .blue
			annotationView = pinAnnotationView
		}
		else {
			annotationView?.annotation = annotation
		}
		return annotationView
	}
}
