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
	@IBOutlet weak var mailTextField: UITextField!
	@IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var signInButton: UIButton!
	
	var fieldsFilled: Bool {
		get {
			return mailTextField.text != "" && passwordTextField.text != ""
		}
	}
	
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
		// api call
	}
	
	@IBAction func cancel(_ sender: UIBarButtonItem) {
		performSegue(withIdentifier: "unwindToAddSpot", sender: nil)
	}
	
	// Helpers
	
	@objc func textFieldDidChange(_ textField: UITextField) {
		signInButton.isEnabled = fieldsFilled
	}
}

extension SignInViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		
		if textField == mailTextField {
			passwordTextField.becomeFirstResponder()
		}
		
		return true
	}
}

