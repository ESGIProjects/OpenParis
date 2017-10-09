//
//  AppDelegate.swift
//  OpenParis
//
//  Created by Kévin Le on 06/09/2017.
//  Copyright © 2017 ESGI. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	static let neighborhoods: [Neighborhood] = [
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
	
	static let attractions: [AttractionType] = [
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
	
	static let roomTypes: [Logement.RoomType: String] = [
		.entireHome: "Entire home",
		.privateRoom: "Private room",
		.sharedRoom: "Shared room"
	]
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		let defaults = UserDefaults.standard
		defaults.removeObject(forKey: "username")
		
		/* if let username = defaults.object(forKey: "username") as? String {
			print(username)
		} else {
			print("Not connected")
			defaults.set("Silver", forKey: "username")
		} */
		
		return true
	}
	
	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}
	
	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}
	
	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}
	
	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
	
	
}

