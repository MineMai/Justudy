//
//  AppDelegate.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/15.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate/*, GIDSignInDelegate*/ {

    var window: UIWindow?
    
    var myActivity = [MyActivity]()
    
    func loadCoredata()
    {
        let context = persistentContainer.viewContext
        do
        {
            let results = try context.fetch(MyActivity.fetchRequest())
            if results.count == 0
            {
                //還沒有存資料
            }
            else
            {
                for item in results
                {
                    if let myAct = item as? MyActivity
                    {
                        myActivity.append(myAct)
                    }
                }
            }
        }
        catch
        {
            print("無法取用CoreData")
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
              
        //設定NavigationBar顏色
        UINavigationBar.appearance().barTintColor = UIColor(red:0.26, green:0.52, blue:0.96, alpha:1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        //設定TabBar顏色
        UITabBar.appearance().tintColor = UIColor(red:1.00, green:0.82, blue:0.00, alpha:1.0)
            //UIColor(red:0.26, green:0.52, blue:0.96, alpha:1.0)
        UITabBar.appearance().barTintColor = UIColor(red:0.26, green:0.52, blue:0.96, alpha:1.0)
            //UIColor(red:1.00, green:0.82, blue:0.00, alpha:1.0)
        
        //讀取CoreData資料
        loadCoredata()
        
        //Firebase
        FIRApp.configure()
        
        //FB
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //Google
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        //GIDSignIn.sharedInstance().delegate = self
        
        
        return true
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        //Google
        GIDSignIn.sharedInstance().handle(url,sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        
        //FB
        let FBHandle = FBSDKApplicationDelegate.sharedInstance().application(app,open: url,sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String,annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return FBHandle
    }
    
    
    //簽完Google協定，要實作的方法
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!)
//    {
//        if let err = error
//        {
//            print("使用Google登入失敗",err)
//            return
//        }
//        print("成功使用Google登入",user)
//        guard let idToken = user.authentication.idToken else { return }
//        guard let accessToken = user.authentication.accessToken else { return }
//        let credentials = FIRGoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
//        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
//            
//            if let err = error
//            {
//                print("用Google連Firebase登入失敗",err)
//                return
//            }
//            guard let uid = user?.uid else { return }
//            print("成功用Google連Firebase登入", uid)
//            print("user?.email = \(user?.email ?? "")")
//        })
//    }
//    
//    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
//        
//        print("Google帳號已登出")
//    }
    

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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "JustStudy")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

