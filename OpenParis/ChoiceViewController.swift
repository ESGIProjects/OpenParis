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
    
    var neighborhoods: [(id: Int, name: String)] = [
        (id: 1, name: "Batignolles-Monceau"),
        (id: 2, name: "Bourse"),
        (id: 3, name: "Buttes-Chaumont"),
        (id: 4, name: "Buttes-Montmartre"),
        (id: 5, name: "Élysée"),
        (id: 6, name: "Entrepôt"),
        (id: 7, name: "Gobelins"),
        (id: 8, name: "Hôtel-de-Ville"),
        (id: 9, name: "Louvre"),
        (id: 10, name: "Luxembourg"),
        (id: 11, name: "Ménilmontant"),
        (id: 12, name: "Observatoire"),
        (id: 13, name: "Opéra"),
        (id: 14, name: "Palais-Bourbon"),
        (id: 15, name: "Panthéon"),
        (id: 16, name: "Passy"),
        (id: 17, name: "Popincourt"),
        (id: 18, name: "Reuilly"),
        (id: 19, name: "Temple"),
        (id: 20, name: "Vaugirard")
    ]

    var attractions: [(id: Int, name: String)] = [
        (id: 7, name: "Principaux parcs, jardins et squares"),
        (id: 12, name: "Autres musées"),
        (id: 27, name: "Piscines municipales"),
        (id: 29, name: "Piscines concédées"),
        (id: 67, name: "Musées municipaux"),
        (id: 68, name: "Musées nationaux"),
        (id: 253, name: "Grands monuments parisiens"),
        (id: 287, name: "Rollers parcs et skate parcs"),
        (id: 289, name: "Marchés alimentaires et spécialisés"),
        (id: 300, name: "Marchés spécialisés")
    ]
    
    var selectedNeighborhood: (id: Int, name: String)?
    var checkedAttractions = [IndexPath]()
    var selectedAttractions = [Int]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = (mode == .neighborhood) ? "Neighborhoods" : "Attractions"
        
        if mode == .attractions {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done(_:)))
        }
    }
	
	@IBAction func cancel(_ sender: UIBarButtonItem) {
		dismiss(animated: true)
	}
    
    func done(_ sender: UIBarButtonItem) {
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
            cell.textLabel?.text = attractions[indexPath.row].name
            
            // keep count of attractions to display checkmark
            if checkedAttractions.contains(indexPath) {
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
            if checkedAttractions.contains(indexPath) {
                checkedAttractions.remove(at: checkedAttractions.index(of: indexPath)!)
                selectedAttractions.remove(at: selectedAttractions.index(of: attractions[indexPath.row].id)!)
            } else {
                checkedAttractions.append(indexPath)
                selectedAttractions.append(attractions[indexPath.row].id)
            }
            
            tableView.reloadData()
        }
    }
}
