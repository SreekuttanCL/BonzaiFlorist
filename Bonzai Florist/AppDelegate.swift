//
//  AppDelegate.swift
//  Bonzai Florist
//
//  Created by Sreekuttan C L on 2019-11-23.
//  Copyright © 2019 Sreekuttan C L. All rights reserved.
//

import UIKit
import Firebase
import Braintree

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        BTAppSwitch.setReturnURLScheme("com.SKSoftTech.Bonzai-Florist.payments")
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options:
        [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        if url.scheme?.localizedCaseInsensitiveCompare("com.SKSoftTech.Bonzai-Florist.payments")
            == .orderedSame
        {
            return BTAppSwitch.handleOpen(url, options: options) }
        return false
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

