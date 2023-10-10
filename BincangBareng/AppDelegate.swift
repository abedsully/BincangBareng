//
//  AppDelegate.swift
//  BincangBareng
//
//  Created by Stefanus Albert Wilson on 10/5/23.
//

import UIKit
import RealmSwift


@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Thread.sleep(forTimeInterval: 3.0)
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        
        do{
            _ = try Realm()
            
        } catch{
            print("Error initializing new realm \(error)")
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }


}
