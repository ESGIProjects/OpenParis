//
//  SignInViewController.swift
//  OpenParis
//
//  Created by Kévin Le on 06/09/2017.
//  Copyright © 2017 ESGI. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
import PKHUD

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
		
		// Fields events
		mailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
		passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
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
		HUD.show(.progress)
		
		let parameters = [
			"mail": mailTextField.text!,
			"password": passwordTextField.text!
		]
		
		Alamofire.request("http://localhost:8080/signin", method: .post, parameters: parameters).validate().responseJSON { [unowned self] response in
			switch response.result {
				
			case .success(let value):
				let json = JSON(value)
				if json["message"].stringValue == "success" {
					let userId = json["id"].intValue
					let userMail = json["mail"].stringValue
					
					UserDefaults.standard.set(userId, forKey: "userId")
					UserDefaults.standard.set(userMail, forKey: "userMail")
					
					HUD.flash(.success, delay: 1.0)
					self.performSegue(withIdentifier: "unwindToAddSpot", sender: self)
				}
				else {
					HUD.flash(.error, delay: 1.0)
				}
				
			case .failure(let error):
				print(error.localizedDescription)
				HUD.flash(.error)
			}
		}
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

