//
//  AppDelegate.swift
//  AdvancedActionSheetExamples
//
//  Created by Ali Samaiee on 9/13/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.setRootViewController()
        return true
    }
    
    private func setRootViewController() {
        if self.window == nil {
            self.window = UIWindow(frame: UIScreen.main.bounds)
        }
        let rootViewController = ViewController()
        self.window?.rootViewController?.removeFromParent()
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
    }
}

