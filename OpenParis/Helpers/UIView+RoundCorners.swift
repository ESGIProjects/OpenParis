//
//  UIView+RoundCorners.swift
//  OpenParis
//
//  Created by Jason Pierna on 08/10/2017.
//  Copyright © 2017 ESGI. All rights reserved.
//

import UIKit

extension UIView {
	func roundCorners(_ corners: UIRectCorner) {
		self.clipsToBounds = true
		
		let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 10, height: 10))
		
		let maskLayer = CAShapeLayer()
		maskLayer.path = path.cgPath
		self.layer.mask = maskLayer
	}
}
