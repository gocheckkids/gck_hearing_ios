//
//  SceneDelegate.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/13/24.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var applicationCoordintor: Coordinator?
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            let firstCoordinator = FirstTabCoodinator()
            firstCoordinator.start()
            let firstViewController = firstCoordinator.firstLoginViewController
            

            let applicationCoordintor = ApplicationCoordinator(window: window)
            applicationCoordintor.start()
          
            self.applicationCoordintor = applicationCoordintor
//            window.rootViewController = firstCoordinator.rootViewController
            window.makeKeyAndVisible()
            
        }
        
    }

}
