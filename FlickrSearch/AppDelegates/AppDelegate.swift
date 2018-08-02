//
//  AppDelegate.swift
//  FlickrSearch
//
//  Created by Hana  Demas on 7/31/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: Properties
    var window: UIWindow?
    
    //MARK: Functions
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let rootViewController = window!.rootViewController as! UINavigationController
        let searchedPhotosViewController = rootViewController.topViewController as! SearchedPhotosViewController
        searchedPhotosViewController.searchAPIDelegate = FlickrAPIClient()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {}
    
    func applicationDidEnterBackground(_ application: UIApplication) {}
    
    func applicationWillEnterForeground(_ application: UIApplication) {}
    
    func applicationDidBecomeActive(_ application: UIApplication) {}
    
    func applicationWillTerminate(_ application: UIApplication) {}
}

