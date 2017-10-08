//
//  SignInViewController.swift
//  OpenParis
//
//  Created by Kévin Le on 06/09/2017.
//  Copyright © 2017 ESGI. All rights reserved.
//

import UIKit

class SignInViewController : UIViewController {
	
	@IBOutlet weak var mailView: UIView!
	@IBOutlet weak var mail: UITextField!
	@IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var password: UITextField!
	
	// MARK: - UIViewController
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		mailView.roundCorners([.topLeft, .topRight])
		passwordView.roundCorners([.bottomLeft, .bottomRight])
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		
		view.endEditing(true)
	}
	
	// MARK: - IBActions
	
	@IBAction func signIn(_ sender: Any) {
		if(mail.text == "" && password.text == ""){
			let alert = UIAlertController(title: "Missing parameters", message: "There is an empty field", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .cancel))
			self.present(alert, animated: true)
		}
		else {
			// api call
		}
	}
}
