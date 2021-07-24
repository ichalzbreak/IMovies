//
//  AppDelegate.swift
//  IMovies
//
//  Created by Amrizal on 22/07/21.
//

import UIKit
import Swinject
import SwinjectStoryboard

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        self.window = window
        
        window.rootViewController = UINavigationController(rootViewController: GenreViewController.instantiate())

        return true
    }



}
