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
    
    var neighborhoods: [Neighborhood] = [
        Neighborhood(id: 1, name: "Batignolles-Monceau"),
        Neighborhood(id: 2, name: "Bourse"),
        Neighborhood(id: 3, name: "Buttes-Chaumont"),
        Neighborhood(id: 4, name: "Buttes-Montmartre"),
        Neighborhood(id: 5, name: "Élysée"),
        Neighborhood(id: 6, name: "Entrepôt"),
        Neighborhood(id: 7, name: "Gobelins"),
        Neighborhood(id: 8, name: "Hôtel-de-Ville"),
        Neighborhood(id: 9, name: "Louvre"),
        Neighborhood(id: 10, name: "Luxembourg"),
        Neighborhood(id: 11, name: "Ménilmontant"),
        Neighborhood(id: 12, name: "Observatoire"),
        Neighborhood(id: 13, name: "Opéra"),
        Neighborhood(id: 14, name: "Palais-Bourbon"),
        Neighborhood(id: 15, name: "Panthéon"),
        Neighborhood(id: 16, name: "Passy"),
        Neighborhood(id: 17, name: "Popincourt"),
        Neighborhood(id: 18, name: "Reuilly"),
        Neighborhood(id: 19, name: "Temple"),
        Neighborhood(id: 20, name: "Vaugirard")
    ]

    var attractions: [AttractionType] = [
        AttractionType(id: 7, name: "Principaux parcs, jardins et squares"),
        AttractionType(id: 12, name: "Autres musées"),
        AttractionType(id: 27, name: "Piscines municipales"),
        AttractionType(id: 29, name: "Piscines concédées"),
        AttractionType(id: 67, name: "Musées municipaux"),
        AttractionType(id: 68, name: "Musées nationaux"),
        AttractionType(id: 253, name: "Grands monuments parisiens"),
        AttractionType(id: 287, name: "Rollers parcs et skate parcs"),
        AttractionType(id: 289, name: "Marchés alimentaires et spécialisés"),
        AttractionType(id: 300, name: "Marchés spécialisés")
    ]
    
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
        return (mode == .neighborhood) ? neighborhoods.count : attractions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChoiceCell", for: indexPath)
        
        if mode == .neighborhood {
            cell.textLabel?.text = neighborhoods[indexPath.row].name
        } else {
			let attractionType = attractions[indexPath.row]
            cell.textLabel?.text = attractionType.name
            
            // keep count of attractions to display checkmark
            if selectedAttractions.contains(attractionType) {
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
            selectedNeighborhood = neighborhoods[indexPath.row]
            performSegue(withIdentifier: "unwindToSearch", sender: self)
        } else {
			let selectedAttraction = attractions[indexPath.row]
			
            if selectedAttractions.contains(selectedAttraction) {
                selectedAttractions.remove(at: selectedAttractions.index(of: selectedAttraction)!)
            } else {
                selectedAttractions.append(attractions[indexPath.row])
            }
            
            tableView.reloadData()
        }
    }
}
