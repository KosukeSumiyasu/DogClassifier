//
//  AppDelegate.swift
//  learnCoreML
//
//  Created by Kousuke Sumiyasu on 2021/12/15.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let rootViewController = PredictionViewController()
        window?.rootViewController = rootViewController

        return true
    }
}
