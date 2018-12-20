//
//  AppDelegate.swift
//  ToDoList
//
//  Created by gopalakrishna on 14/12/18.
//  Copyright © 2018 gopalakrishna. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       // print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
             _ = try Realm()
           
        }catch{
            print("Error occur configuring Realm,\(error)")
        }
        return true
    }
}
