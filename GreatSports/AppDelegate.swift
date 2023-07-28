//
//  AppDelegate.swift
//  GreatSports
//
//  Created by Russel Dev on 25/07/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
     
        let newNavBarAppearance =  UINavigationBarAppearance()
        newNavBarAppearance.configureWithOpaqueBackground()
        newNavBarAppearance.backgroundColor = UIColor(named: "PrimaryColor")
        newNavBarAppearance.shadowColor = .clear
       
            let appearance = UINavigationBar.appearance()
       // appearance.configureWithOpaqueBackground()
            appearance.scrollEdgeAppearance = newNavBarAppearance
            appearance.compactAppearance = newNavBarAppearance
            appearance.standardAppearance = newNavBarAppearance
            if #available(iOS 15.0, *) {
                appearance.compactScrollEdgeAppearance = newNavBarAppearance
            }
        return true
    }


}

