//
//  AppDelegate.swift
//  GOOGLE_FB_SigniIn
//
//  Created by Appinventiv Mac on 27/03/18.
//  Copyright © 2018 Appinventiv Mac. All rights reserved.
//

import UIKit
import GoogleSignIn
import FacebookCore
import FacebookLogin
import FBSDKCoreKit
import GoogleMaps
import GooglePlaces


protocol SignInSuccess {
    func mydata(_ name:String?,_ email:String?)
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {
    
    var delegate:SignInSuccess?
    var name,email:String?
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            self.name = user.profile.name
            self.email = user.profile.email
            print(self.email!)
            print(self.name!)
            self.delegate?.mydata(self.name, self.email)

            // ...
        }
    }
    

    var window: UIWindow?


   
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyBXSZOOoR3kNLHEy1maOLnJzrUoGZRgAIM")
        GMSPlacesClient.provideAPIKey("AIzaSyBXSZOOoR3kNLHEy1maOLnJzrUoGZRgAIM")
        AppEventsLogger.activate(application)
        GIDSignIn.sharedInstance().clientID = "47136168792-0lcmnml5i0ji6c01m1e7r8b16ct39rtj.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
       
        return GIDSignIn.sharedInstance().handle(url,
                                                        sourceApplication: options[.sourceApplication] as? String,
                                                        annotation: options[.annotation])
      
        

    }
    func applicationWillResignActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
   
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        AppEventsLogger.activate(application)

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

