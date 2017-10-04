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
    var duration = 1
    var selectedAttractions = [Int]()
    var selectedNeighborhood: (id: Int, name: String)?
	
	var receivedJSON: JSON?
	
	override func viewDidLoad() {
		super.viewDidLoad()
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
    
    @IBAction func unwindToSearch(_ segue: UIStoryboardSegue) {
        if segue.source is ChoiceViewController {
            let source = segue.source as! ChoiceViewController
            
            if source.mode == .neighborhood {
                selectedNeighborhood = source.selectedNeighborhood!
                neighborhoodLabel.text = selectedNeighborhood!.name
            } else {
                selectedAttractions = source.selectedAttractions
                attractionsLabel.text = "\(selectedAttractions.count)"
            }
			
			tableView.reloadData()            
        }
    }
    
    @IBAction func search(_ sender: UIButton) {
        if let url = url() {
            Alamofire.request(url, method: .get).validate().responseJSON { response in
                switch response.result {
                    
                case .success(let value):
                    self.receivedJSON = JSON(value)
					print("JSON: \(String(describing: self.receivedJSON))")
                    self.performSegue(withIdentifier: "resultsSegue", sender: self)
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "choiceSegue" {
			
			guard let navigationController = segue.destination as? UINavigationController,
				let controller = navigationController.childViewControllers.first as? ChoiceViewController,
				let choice = sender as? ChoiceViewController.Choice
			else { return }
			
			controller.mode = choice
        }
		
		if segue.identifier == "resultsSegue" {
			guard let controller = segue.destination as? ResultsViewController,
				let json = receivedJSON
			else { return }
			
			controller.json = json
		}
    }

    func url() -> String? {
        let address = "http://172.20.10.2:8080"
        let endpoint = "\(address)/psearch"
        
        if let neighborhood = selectedNeighborhood {
            var parameters = [String: String]()
            parameters["priceMin"] = "\(priceMin)"
            parameters["priceMax"] = "\(priceMax)"
            parameters["duration"] = "\(duration)"
            parameters["neighborhood"] = "\(neighborhood.id)"
            
            let attractionStringArray = selectedAttractions.map { "\($0)" }
            parameters["attractions"] = attractionStringArray.joined(separator: ",")
            
            var parametersString = ""
            for (key, parameter) in parameters {
                parametersString.append("&\(key)=\(parameter)")
            }
            parametersString.remove(at: parametersString.startIndex)
            
            
            
            return "\(endpoint)?\(parametersString)"
        }
        return nil
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 2 {
            if indexPath.row == 1 {
                performSegue(withIdentifier: "choiceSegue", sender: ChoiceViewController.Choice.neighborhood)
            }
            if indexPath.row == 2 {
                performSegue(withIdentifier: "choiceSegue", sender: ChoiceViewController.Choice.attractions)
            }
        }
    }
}
