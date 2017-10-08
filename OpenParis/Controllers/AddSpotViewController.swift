//
//  AddSpotViewController.swift
//  OpenParis
//
//  Created by Kévin Le on 06/09/2017.
//  Copyright © 2017 ESGI. All rights reserved.
//

import UIKit

class AddSpotViewController : UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		performSegue(withIdentifier: "signIn", sender: nil)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	@IBAction func unwindToAddSpot(_ segue: UIStoryboardSegue) {
		// normally connected, but check in case - if not, push sign-in controller back
	}
}
