//
//  MainViewController.swift
//  OpenParis
//
//  Created by Kévin Le on 06/09/2017.
//  Copyright © 2017 ESGI. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBAction func addSpot(_ sender: UIButton) {
        if UserDefaults.standard.object(forKey: "token") != nil {
            // ok, transition
            performSegue(withIdentifier: "AddSpot", sender: self)
        }
        else {
            // pas ok, transition
            performSegue(withIdentifier: "SignUp", sender: self)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        <#code#>
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

