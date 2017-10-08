//
//  SignUpViewController.swift
//  OpenParis
//
//  Created by Kévin Le on 06/09/2017.
//  Copyright © 2017 ESGI. All rights reserved.
//

import UIKit

class SignUpViewController : UIViewController{
	
	@IBOutlet weak var mailView: UIView!
	@IBOutlet weak var mailTextField: UITextField!
	@IBOutlet weak var confirmMailView: UIView!
	@IBOutlet weak var confirmMailTextField: UITextField!
	@IBOutlet weak var passwordView: UIView!
	@IBOutlet weak var paswordTextField: UITextField!
	@IBOutlet weak var confirmPasswordView: UIView!
	@IBOutlet weak var confirmPasswordTextField: UITextField!
	@IBOutlet weak var signUpButton: UIButton!
	
	// MARK: - UIViewController
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		signUpButton.clipsToBounds = true
		signUpButton.layer.cornerRadius = 10
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		mailView.roundCorners([.topLeft, .topRight])
		confirmMailView.roundCorners([.bottomLeft, .bottomRight])
		passwordView.roundCorners([.topLeft, .topRight])
		confirmPasswordView.roundCorners([.bottomLeft, .bottomRight])
	}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		
        view.endEditing(true)
    }    
}
