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
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var confirmPasswordView: UIView!
	@IBOutlet weak var confirmPasswordTextField: UITextField!
	@IBOutlet weak var signUpButton: UIButton!
	
	var fieldsFilled: Bool {
		get {
			return mailTextField.text != "" && confirmMailTextField.text != ""
				&& passwordTextField.text != "" && confirmPasswordTextField.text == ""
		}
	}
	
	// MARK: - UIViewController
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Sign Up button layout
		signUpButton.clipsToBounds = true
		signUpButton.layer.cornerRadius = 10
		
		// Text fields events
		mailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
		confirmMailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
		passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
		confirmPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
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
	
	// MARK: - IBActions
	
	@IBAction func signUp(_ sender: UIBarButtonItem) {
		if mailTextField.text != confirmMailTextField.text {
			let alert = UIAlertController(title: "Different mails", message: "Both mail fields have to be the same.", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
				self.confirmMailTextField.becomeFirstResponder()
			})
			
			present(alert, animated: true)
			return
		}
		
		if passwordTextField.text != confirmPasswordTextField.text {
			let alert = UIAlertController(title: "Different passwords", message: "Both password fields have to be the same.", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
				self.confirmPasswordTextField.text = ""
				self.confirmPasswordTextField.becomeFirstResponder()
			})
			
			present(alert, animated: true)
			return
		}
		
		// api call
		performSegue(withIdentifier: "unwindToAddSpot", sender: nil)

		
	}
	
	// MARK: - Helpers
	
	@objc func textFieldDidChange(_ textField: UITextField) {
		signUpButton.isEnabled = fieldsFilled
		signUpButton.alpha = fieldsFilled ? 1 : 0.5
	}
}

extension SignUpViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		
		if textField == mailTextField {
			confirmMailTextField.becomeFirstResponder()
		}
		
		if textField == confirmMailTextField {
			passwordTextField.becomeFirstResponder()
		}
		
		if textField == passwordTextField {
			confirmPasswordTextField.becomeFirstResponder()
		}
		
		return true
	}
}
