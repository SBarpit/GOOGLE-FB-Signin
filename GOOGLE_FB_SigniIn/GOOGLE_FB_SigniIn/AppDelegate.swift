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
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var name,email:String?
    
    
    

    var window: UIWindow?

/*
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
     
     //MARK:--> Initialize facebook SDK
     
     FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
     
     //MARK:--> Providing client ID and google sign in delegate
    
     GIDSignIn.sharedInstance().clientID = "217652371245-ftqsu0p0gj31u3j6kkslk9t8rvg4077c.apps.googleusercontent.com"
     GIDSignIn.sharedInstance().delegate = self
     
     //MARK:--> Providing API key to google maps and places
     
     GMSServices.provideAPIKey("AIzaSyCTsuqQHKE76BKkodBzMMilo9z4s7rMq10")
     GMSPlacesClient.provideAPIKey("AIzaSyCTsuqQHKE76BKkodBzMMilo9z4s7rMq10")
     
     return true
     
     }
     
     func applicationWillResignActive(_ application: UIApplication) {
     
     //MARK: --> to handle app states
     
     FBSDKAppEvents.activateApp()
     
     }
     
     //MARK:--> Method to handle Google sign in
     
     func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
     
     return GIDSignIn.sharedInstance().handle(url,
     sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
     annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    
     }
     
     //MARK:--> Perform operations after signing into google
     
     func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
     withError error: Error!) {
     
     if let error = error {
     
     print("\(error.localizedDescription)")
     
     } else {
     
     //      let userId = user.userID                  // For client-side use only!
     //      let idToken = user.authentication.idToken // Safe to send to the server
     //      let fullName = user.profile.name
     //      let givenName = user.profile.givenName
     //      let familyName = user.profile.familyName
     //      let email = user.profile.email
     
     }
     }
     
     //MARK:--> Perform any operations when the user disconnects from google from app here.
     
     func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
     withError error: Error!) {
     
     MapsViewController().navigationController?.popViewController(animated: true)
     
     }
     
     func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
     
     let googleDidHandle = GIDSignIn.sharedInstance().handle(url,
     sourceApplication: sourceApplication,
     annotation: annotation)
     
     let facebookDidHandle = FBSDKApplicationDelegate.sharedInstance().application(
     application,
     open: url,
     sourceApplication: sourceApplication,
     annotation: annotation)
     
     return googleDidHandle || facebookDidHandle
     }
     
     */
   
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyBXSZOOoR3kNLHEy1maOLnJzrUoGZRgAIM")
        GMSPlacesClient.provideAPIKey("AIzaSyBXSZOOoR3kNLHEy1maOLnJzrUoGZRgAIM")
        AppEventsLogger.activate(application)
        GIDSignIn.sharedInstance().clientID = "47136168792-0lcmnml5i0ji6c01m1e7r8b16ct39rtj.apps.googleusercontent.com"
//        GIDSignIn.sharedInstance().delegate = self
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

