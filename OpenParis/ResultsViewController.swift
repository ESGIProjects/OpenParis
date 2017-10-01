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
	@IBOutlet var mapViewExpandedHeightConstraint: NSLayoutConstraint!
	@IBOutlet var mapViewCollapsedHeightConstraint: NSLayoutConstraint!
	
	var json: JSON!
	var expanded = false
	
	func expandMap(_ sender: UIBarButtonItem) {
		print("expandMap")
		
		if expanded {
			sender.title = "Expand"
			mapViewExpandedHeightConstraint.isActive = false
			mapViewCollapsedHeightConstraint.isActive = true
			//self.view.removeConstraint(mapViewExpandedHeightConstraint)
			//self.view.addConstraint(mapViewCollapsedHeightConstraint)
			view.layoutIfNeeded()
		} else {
			sender.title = "Collapse"
			
			mapViewCollapsedHeightConstraint.isActive = false
			mapViewExpandedHeightConstraint.isActive = true
			//self.view.removeConstraint(mapViewCollapsedHeightConstraint)
			//self.view.addConstraint(mapViewExpandedHeightConstraint)
			view.layoutIfNeeded()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Expand", style: .plain, target: self, action: #selector(expandMap(_:)))
		
		let center = CLLocationCoordinate2D(latitude: json["array"][0]["latitude"].doubleValue, longitude: json["array"][0]["longitude"].doubleValue)
		let span = MKCoordinateSpan(latitudeDelta: 0.027, longitudeDelta: 0.027)
		var region = MKCoordinateRegion(center: center, span: span)
		region = mapView.regionThatFits(region)
		mapView.setRegion(region, animated: true)

		for place in json["array"][0]["places"].arrayValue {
			let coordinate = CLLocationCoordinate2D(latitude: place["latitude"].doubleValue, longitude: place["longitude"].doubleValue)
			let annotation = MKPointAnnotation()
			annotation.coordinate = coordinate
			annotation.title = place["name"].stringValue
			mapView.addAnnotation(annotation)
		}
	}
}

extension ResultsViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return json["array"][0]["places"].arrayValue.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as? EntryCell else {
			return UITableViewCell(style: .default, reuseIdentifier: "EntryCell")
		}
		
		cell.nameLabel.text = json["array"][0]["places"][indexPath.row]["name"].stringValue
		cell.priceLabel.text = "\(json["array"][0]["places"][indexPath.row]["zipCode"].intValue)"
		
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
		
		var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "id")
		
		if annotationView == nil {
			let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "id")
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

extension NSLayoutConstraint {
	func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
		return NSLayoutConstraint(item: self.firstItem, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
	}
}
