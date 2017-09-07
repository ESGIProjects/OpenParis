//
//  FiltersViewController.swift
//  OpenParis
//
//  Created by Kévin Le on 06/09/2017.
//  Copyright © 2017 ESGI. All rights reserved.
//

import UIKit

class FiltersViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var budgetMin: UITextField!
    @IBOutlet weak var budgetMax: UITextField!
    @IBOutlet weak var duration: UIPickerView!
    @IBOutlet weak var neighborhood: UIPickerView!
    
    var durationValues: [String] = ["1","2","3","4","5","6","7+"]
    var neighborhoodValues: [String] = ["Reuilly","Batignolles-Monceau","Palais-Bourbon","Buttes-Chaumont","Opéra","Entrepôt","Gobelins","Vaugirard","Louvre","Luxembourg","Élysée","Temple","Ménilmontant","Panthéon","Passy","Observatoire","Popincourt","Bourse","Buttes-Montmartre","Hôtel-de-Ville"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        duration.delegate = self
        duration.dataSource = self
        
        neighborhood.delegate = self
        neighborhood.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView === duration {
            return durationValues.count
        }
        return neighborhoodValues.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView === duration{
            return durationValues[row]
        }
        return neighborhoodValues[row]
    }

}
