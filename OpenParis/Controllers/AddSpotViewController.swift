//
//  AddSpotViewController.swift
//  OpenParis
//
//  Created by Kévin Le on 06/09/2017.
//  Copyright © 2017 ESGI. All rights reserved.
//

import UIKit
import CoreLocation

import Alamofire
import SwiftyJSON
import PKHUD

class AddSpotViewController : UITableViewController {
	
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var addressTextField: UITextField!
	@IBOutlet weak var zipCodeTextField: UITextField!
	@IBOutlet weak var attractionLabel: UILabel!
	
	var selectedAttraction: AttractionType?
	var fieldsFilled: Bool {
		get {
			return nameTextField.text != "" && addressTextField.text != ""
				&& zipCodeTextField.text != "" && selectedAttraction != nil
		}
	}
	
	// MARK: - UIViewController
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if UserDefaults.standard.object(forKey: "userId") != nil {
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
		let userId = UserDefaults.standard.integer(forKey: "userId")
		if userId > 0 {
			if fieldsFilled {
				// api call
				
				HUD.show(.progress)
				
				let geoCoder = CLGeocoder()
				
				let completeAddress = "\(addressTextField.text!) \(zipCodeTextField.text!) Paris"
				
				geoCoder.geocodeAddressString(completeAddress) { [unowned self] placemarks, error in
					guard let placemarks = placemarks, let location = placemarks.first?.location else {
						HUD.flash(.error)
						
						let alertController = UIAlertController(title: "Error with address", message: "We could not locate the address.", preferredStyle: .alert)
						alertController.addAction(UIAlertAction(title: "OK", style: .default))
						self.present(alertController, animated: true)
						
						return
					}
					
					let parameters: [String: Any] = [
						"name": self.nameTextField.text!,
						"address": self.addressTextField.text!,
						"zipCode": self.zipCodeTextField.text!,
						"latitude": location.coordinate.latitude,
						"longitude": location.coordinate.longitude,
						"catId": self.selectedAttraction!.id,
						"userId": userId
					]
					
					Alamofire.request("http://localhost:8080/places", method: .post, parameters: parameters).validate().responseJSON { response in
						switch response.result {
							
						case .success(let value):
							let json = JSON(value)
							if json["message"].stringValue == "success" {
								self.nameTextField.text = ""
								self.addressTextField.text = ""
								self.zipCodeTextField.text = ""
								self.selectedAttraction = nil
								self.attractionLabel.text = ""
								
								HUD.flash(.success, delay: 1.0)
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
			}
			else {
				let alertController = UIAlertController(title: "Missing fields", message: "You need to fill all the fields.", preferredStyle: .alert)
				alertController.addAction(UIAlertAction(title: "OK", style: .default))
				present(alertController, animated: true)
			}
		} else {
			performSegue(withIdentifier: "signIn", sender: nil)
		}
	}
	
	@IBAction func unwindToAddSpot(_ segue: UIStoryboardSegue) {
		// check if connected
		if segue.source is SignInViewController || segue.source is SignUpViewController {
			if UserDefaults.standard.object(forKey: "userId") != nil {
				navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "signOut"), style: .plain, target: self, action: #selector(signOut(_:)))
			}
		}
		
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
			UserDefaults.standard.removeObject(forKey: "userId")
			UserDefaults.standard.removeObject(forKey: "userMail")
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
