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
	@IBOutlet weak var attractionLabel: UILabel!
	
	var selectedAttraction: AttractionType?
	
	// MARK: - UIViewController
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if UserDefaults.standard.object(forKey: "username") != nil {
			navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "signOut"), style: .plain, target: self, action: #selector(signOut(_:)))
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "choiceSegue" {
			guard let navigationController = segue.destination as? UINavigationController,
				let controller = navigationController.childViewControllers.first as? ChoiceViewController
				else { return }
			
			controller.mode = .attractions
			controller.multipleAttractions = false
		}
	}
	
	// MARK: - UITableViewDelegate
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		if indexPath.section == 0 && indexPath.row == 3 {
			performSegue(withIdentifier: "choiceSegue", sender: nil)
		}
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
		
		// back from choice
		if let source = segue.source as? ChoiceViewController {
			selectedAttraction = source.selectedAttractions.first
			
			if let selectedAttraction = selectedAttraction {
				attractionLabel.text = selectedAttraction.name
			}
		}
	}
	
	// MARK: - Helpers
	
	@objc func signOut(_ sender: UIBarButtonItem) {
		
		let alert = UIAlertController(title: "Sign Out of OpenParis ?", message: "Are you sure to sign out ?", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		alert.addAction(UIAlertAction(title: "Sign Out", style: .destructive) { [unowned self] _ in
			UserDefaults.standard.removeObject(forKey: "username")
			self.navigationItem.rightBarButtonItem = nil
		})
		
		present(alert, animated: true)
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
