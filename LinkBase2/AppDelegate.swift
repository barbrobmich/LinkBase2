//
//  AppDelegate.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/8/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        Parse.initialize(
            with: ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) in
                configuration.applicationId = "linkbase"
                configuration.clientKey = "fasfsaf0-isa9f898f09809f80sa809fsd9a"
                configuration.server = "https://barbrobmich.herokuapp.com/parse"
            })
        )

        Item.registerSubclass()

        if PFUser.current() == nil {
            print("There is no current user")
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Signup", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "Login")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
        //Check if user exists and logged in
        else if let user = PFUser.current() {
                if user.isAuthenticated {
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let initialViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                    self.window?.rootViewController = initialViewController
                    self.window?.makeKeyAndVisible()
                }
            }

        // MARK: - NOTIFICATIONS FOR USER LOGIN, SIGN UP AND LOGOUT

        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "UserDidLogIn"), object: nil, queue: OperationQueue.main, using: { (NSNotification) -> Void in
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()

        })

        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "UserDidSignUp"), object: nil, queue: OperationQueue.main, using: { (NSNotification) -> Void in
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Signup", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "AddItem")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()

        })

        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "UserDidLogOut"), object: nil, queue: OperationQueue.main, using: { (NSNotification) -> Void in

            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Signup", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "Login")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        })


        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

