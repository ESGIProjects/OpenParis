//
//  FiltersViewController.swift
//  OpenParis
//
//  Created by Kévin Le on 06/09/2017.
//  Copyright © 2017 ESGI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FiltersViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var budgetMin: UITextField!
    @IBOutlet weak var budgetMax: UITextField!
    @IBOutlet weak var duration: UIPickerView!
    @IBOutlet weak var neighborhood: UIPickerView!
    
    @IBAction func search(_ sender: Any) {
        
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
    }
    
    var durationValues: [String] = ["1","2","3","4","5","6","7+"]
    var neighborhoodValues: [Int:String] = [1 : "Batignolles-Monceau",2 : "Bourse", 3 : "Buttes-Chaumont", 4 : "Buttes-Montmartre", 5 : "Élysée", 6 : "Entrepôt", 7 : "Gobelins", 8 : "Hôtel-de-Ville", 9 : "Louvre", 10 : "Luxembourg", 11 : "Ménilmontant", 12 : "Observatoire", 13 : "Opéra", 14 : "Palais-Bourbon", 15 : "Panthéon", 16 : "Passy", 17 : "Popincourt", 18 : "Reuilly", 19 : "Temple", 20 : "Vaugirard"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        duration.delegate = self
        duration.dataSource = self
        
        neighborhood.delegate = self
        neighborhood.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "List"{
            
        }
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
        return neighborhoodValues[row+1]
    }
    
    func prepareStatement(_ budgetMin: String, _ budgetMax: String, _ duration: String, _ neighborhood: Int) -> String {
        return "http://172.20.10.2:8080/search?priceMin=\(budgetMin)&priceMax=\(budgetMax)&duration=\(duration)&neighborhood=\(neighborhood)"
    }
}
