//
//  AppDelegate.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 12/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private(set) var coreDataManager: DatabaseManager?

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DotaHeroes")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                debugPrint("Error when loading core data \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        coreDataManager = DatabaseManager(persistentContainer: persistentContainer)

        let router = MainWireframe()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = router.viewController
        window?.makeKeyAndVisible()

        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        coreDataManager?.saveContext()
    }
}
