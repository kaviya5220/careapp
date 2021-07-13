//
//  AppDelegate.swift
//  appUIKit
//
//  Created by sysadmin on 09/06/21.
//

import UIKit

@main 
class AppDelegate: UIResponder, UIApplicationDelegate,changeRootView {
    func changeRootVIewController() {
        print("Hii")
    }
    
    var window: UIWindow?
        
        var navController: UINavigationController = UINavigationController()

//        private var auth: LoginViewController {
//            return LoginViewController.shared
//        }
//
    



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
                        self.window = UIWindow(frame: UIScreen.main.bounds)
                
                        let viewController = ReceiverViewController()
                        navController.viewControllers = [viewController]
                        navController.navigationBar.backgroundColor = .clear
                        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
                        navController.navigationBar.titleTextAttributes = textAttributes
                        self.window?.rootViewController = navController
                        self.window?.makeKeyAndVisible()
                        return true

        
            
       
        // Override point for customization after application launch.
        //if let windowScene = scene as? UIWindowScene {

           // let window = UIWindow(windowScene: windowScene)
       
        
      //  IQKeyboardManager.shared().isEnabled = true
       
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        print("Discarded")
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

