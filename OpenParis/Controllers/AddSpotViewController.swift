//
//  AddSpotViewController.swift
//  OpenParis
//
//  Created by Kévin Le on 06/09/2017.
//  Copyright © 2017 ESGI. All rights reserved.
//

import UIKit

class AddSpotViewController : UITableViewController {
	
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var addressTextField: UITextField!
	@IBOutlet weak var zipCodeTextField: UITextField!
	
	var selectedAttraction: AttractionType?
	
	// MARK: - UIViewController
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		
		view.endEditing(true)
	}
	
	// MARK: - IBActions
	
	@IBAction func add(_ sender: UIButton) {
		if let username = UserDefaults.standard.object(forKey: "username") as? String {
			print(username)
		} else {
			performSegue(withIdentifier: "signIn", sender: nil)
		}
	}
	
	@IBAction func unwindToAddSpot(_ segue: UIStoryboardSegue) {
		// check if connected
		// if connected, request
		
	}
}

extension AddSpotViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		
		if textField == nameTextField {
			addressTextField.becomeFirstResponder()
		}
		
		if textField == addressTextField {
			zipCodeTextField.becomeFirstResponder()
		}
		
		return true
	}
}
