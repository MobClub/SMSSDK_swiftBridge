//
//  AppDelegate.swift
//  SMSSDKSwiftDemo
//
//  Created by youzu_Max on 2017/8/8.
//  Copyright © 2017年 youzu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController.init(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        return true
    }
}

