//
//  SearchViewController.swift
//  OpenParis
//
//  Created by Kévin Le on 06/09/2017.
//  Copyright © 2017 ESGI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController : UITableViewController {
	
	@IBOutlet var minPriceLabel: UILabel!
	@IBOutlet var maxPriceLabel: UILabel!
	@IBOutlet var nightsLabel: UILabel!
	@IBOutlet var neighborhoodLabel: UILabel!
	@IBOutlet var attractionsLabel: UILabel!
	
	var priceMin = 200
	var priceMax = 500
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@IBAction func search(_ sender: UIButton) {
		print("search tapped")
	}
	
	@IBAction func changePrice(_ sender: UISlider) {
		let label: UILabel!
		let value: Int!
		
		if sender.tag == 1 {
			label = minPriceLabel
			value = Int(sender.value)
			priceMin = value
		} else {
			label = maxPriceLabel
			value = Int(sender.value)
			priceMax = value
		}
		
		label.text = (value == Int(sender.maximumValue)) ? "\(value!)+ €" : "\(value!) €"
		
	}
	
	@IBAction func changeDuration(_ sender: UIStepper) {
		let value = Int(sender.value)
		nightsLabel.text = (value == Int(sender.maximumValue)) ? "\(value)+ nights" : "\(value) nights"
	}
	
	/*
    @IBAction func oldsearch(_ sender: Any) {
        
        let statement = prepareStatement(budgetMin.text!, budgetMax.text!, durationValues[duration.selectedRow(inComponent: 0)], neighborhood.selectedRow(inComponent: 0) + 1)
        
        print(statement)
        
        Alamofire.request(statement, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                self.performSegue(withIdentifier: "List", sender: self)
                
            case .failure(let error):
                print(error)
            }
        }
    }*/
    
    var neighborhoodValues: [Int:String] = [1 : "Batignolles-Monceau",2 : "Bourse", 3 : "Buttes-Chaumont", 4 : "Buttes-Montmartre", 5 : "Élysée", 6 : "Entrepôt", 7 : "Gobelins", 8 : "Hôtel-de-Ville", 9 : "Louvre", 10 : "Luxembourg", 11 : "Ménilmontant", 12 : "Observatoire", 13 : "Opéra", 14 : "Palais-Bourbon", 15 : "Panthéon", 16 : "Passy", 17 : "Popincourt", 18 : "Reuilly", 19 : "Temple", 20 : "Vaugirard"]
	
    
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		if indexPath.section == 2 {
			if indexPath.row == 1 {
				performSegue(withIdentifier: "choiceSegue", sender: Choice.neighborhood)
			}
			if indexPath.row == 2 {
				performSegue(withIdentifier: "choiceSegue", sender: Choice.attractions)
			}
		}
	}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "choiceSegue" {
			
			guard let navigationController = segue.destination as? UINavigationController,
				let controller = navigationController.childViewControllers.first as? ChoiceViewController,
				let choice = sender as? Choice
			else { return }
			
			controller.mode = choice
        }
		
		if segue.identifier == "resultsSegue" {
			
		}
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
	
    func prepareStatement(_ budgetMin: String, _ budgetMax: String, _ duration: String, _ neighborhood: Int) -> String {
        return "http://172.20.10.2:8080/search?priceMin=\(budgetMin)&priceMax=\(budgetMax)&duration=\(duration)&neighborhood=\(neighborhood)"
    }
}

enum Choice {
	case neighborhood, attractions
}
