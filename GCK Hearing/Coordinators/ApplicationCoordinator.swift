//
//  ApplicationCoordinator.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/13/24.
//

import SwiftUI
import UIKit


class ApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    
    var childCoordinators = [Coordinator]()
 
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let firstCoordinator = FirstTabCoodinator()
        firstCoordinator.start()
        self.childCoordinators = [firstCoordinator]
        self.window.rootViewController = firstCoordinator.rootViewController
    }
}

