//
//  SceneDelegate.swift
//  SimpleAddStoreData
//
//  Created by  Rath! on 18/8/23.
//

import UIKit
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        /// 1. Capture the scene
              guard let windowScene = (scene as? UIWindowScene) else { return }
              
              /// 2. Create a new UIWindow using the windowScene constructor which takes in a window scene.
              let window = UIWindow(windowScene: windowScene)
              
              /// 3. Create a view hierarchy programmatically
              let viewController = WelcomeViewController()
              let navigation = UINavigationController(rootViewController: viewController)
              
              /// 4. Set the root view controller of the window with your view controller
              window.rootViewController = navigation
              
              /// 5. Set the window and call makeKeyAndVisible()
              self.window = window
              window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print("1")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
//        print("2")
//        let userDefaults = UserDefaults.standard
//        userDefaults.set(false, forKey: "isFirstTimeHome")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("3")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("4")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("5")
    }

}

