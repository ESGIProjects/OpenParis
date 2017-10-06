//
//  Logement.swift
//  OpenParis
//
//  Created by Jason Pierna on 06/10/2017.
//  Copyright © 2017 ESGI. All rights reserved.
//

import Foundation
import SwiftyJSON

class Logement {
	var id: Int
	var name: String
	var host: Int
	var neighborhood: Int
	var latitude: Double
	var longitude: Double
	var roomType: String
	var price: Int
	var minimumNights: Int
	var totalReviews: Int
	var places: [Place]
	
	init(id: Int, name: String, host: Int, neighborhood: Int, latitude: Double, longitude: Double, roomType: String, price: Int, minimumNights: Int, totalReviews: Int, places: [Place]?) {
		self.id = id
		self.name = name
		self.host = host
		self.neighborhood = neighborhood
		self.latitude = latitude
		self.longitude = longitude
		self.roomType = roomType
		self.price = price
		self.minimumNights = minimumNights
		self.totalReviews = totalReviews
		
		if let places = places {
			self.places = places
		}
		else {
			self.places = [Place]()
		}
	}
	
	init(json: JSON) {
		id = json["id"].intValue
		name = json["name"].stringValue
		host = json["hostId"].intValue
		neighborhood = json["neighborhood"].intValue
		latitude = json["latitude"].doubleValue
		longitude = json["longitude"].doubleValue
		roomType = json["roomType"].stringValue
		price = json["price"].intValue
		minimumNights = json["minNights"].intValue
		totalReviews = json["nbReviews"].intValue
		
		places = [Place]()
		
		for placeJSON in json["places"].arrayValue {
			let place = Place(json: placeJSON)
			places.append(place)
		}
	}
}
