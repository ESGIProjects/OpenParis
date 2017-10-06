//
//  Place.swift
//  OpenParis
//
//  Created by Jason Pierna on 06/10/2017.
//  Copyright © 2017 ESGI. All rights reserved.
//

import Foundation
import SwiftyJSON

class Place {
	var id: Int
	var name: String
	var address: String
	var zipCode: Int
	var latitude: Double
	var longitude: Double
	var categorie: Int
	var user: Int?
	
	init(id: Int, name: String, address: String, zipCode: Int, latitude: Double, longitude: Double, categorie: Int, user: Int?) {
		self.id = id
		self.name = name
		self.address = address
		self.zipCode = zipCode
		self.latitude = latitude
		self.longitude = longitude
		self.categorie = categorie
		self.user = user
	}
	
	init(json: JSON) {
		id = json["id"].intValue
		name = json["name"].stringValue
		address = json["address"].stringValue
		zipCode = json["zipCode"].intValue
		latitude = json["latitude"].doubleValue
		longitude = json["longitude"].doubleValue
		categorie = json["cat_id"].intValue
		user = json["user_id"].int
	}
}

