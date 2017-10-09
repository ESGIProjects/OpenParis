//
//  ChoiceViewController.swift
//  OpenParis
//
//  Created by Jason Pierna on 08/09/2017.
//  Copyright © 2017 ESGI. All rights reserved.
//

import UIKit

class ChoiceViewController: UITableViewController {
    
    enum Choice {
        case neighborhood, attractions
    }

	var mode: Choice!
	var multipleAttractions: Bool = true
    
    var selectedNeighborhood: Neighborhood?
	var selectedAttractions = [AttractionType]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = (mode == .neighborhood) ? "Neighborhoods" : "Attractions"
        
        if mode == .attractions {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done(_:)))
			tableView.reloadData()
        }
    }
	
	@IBAction func cancel(_ sender: UIBarButtonItem) {
		dismiss(animated: true)
	}
    
    @objc func done(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToSearch", sender: self)
    }
}

// MARK: - UITableViewDataSource
extension ChoiceViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (mode == .neighborhood) ? AppDelegate.neighborhoods.count : AppDelegate.attractions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChoiceCell", for: indexPath)
        
        if mode == .neighborhood {
            cell.textLabel?.text = AppDelegate.neighborhoods[indexPath.row].name
        } else {
			let attractionType = AppDelegate.attractions[indexPath.row]
            cell.textLabel?.text = attractionType.name
            
            // keep count of attractions to display checkmark
            if selectedAttractions.contains(attractionType) && multipleAttractions {
                cell.accessoryType = .checkmark
            }
            else {
                cell.accessoryType = .none
            }
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ChoiceViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if mode == .neighborhood {
            selectedNeighborhood = AppDelegate.neighborhoods[indexPath.row]
            performSegue(withIdentifier: "unwindToSearch", sender: self)
        } else {
			if !multipleAttractions {
				selectedAttractions.append(AppDelegate.attractions[indexPath.row])
				performSegue(withIdentifier: "unwindToAddSpot", sender: self)
			} else {
				let selectedAttraction = AppDelegate.attractions[indexPath.row]
				
				if selectedAttractions.contains(selectedAttraction) {
					selectedAttractions.remove(at: selectedAttractions.index(of: selectedAttraction)!)
				} else {
					selectedAttractions.append(AppDelegate.attractions[indexPath.row])
				}
			}
            
            tableView.reloadData()
        }
    }
}
