//
//  AttractionType.swift
//  OpenParis
//
//  Created by Jason Pierna on 07/10/2017.
//  Copyright © 2017 ESGI. All rights reserved.
//

import Foundation

struct AttractionType: Equatable {
	
	var id: Int
	var name: String
	
	init(id: Int, name: String) {
		self.id = id
		self.name = name
	}
	
	static func ==(lhs: AttractionType, rhs: AttractionType) -> Bool {
		return lhs.id == rhs.id && lhs.name == rhs.name
	}
}
