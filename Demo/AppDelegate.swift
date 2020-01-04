//
//  AppDelegate.swift
//
//  Created by Ivan Tishchenko on 05.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit
import RxSwift
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private let dependencyProvider = DependencyProvider()
    private var applicationCoordinator: ApplicationCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        applicationCoordinator = ApplicationCoordinator(window: window,
                                                        router: Router(),
                                                        resolver: dependencyProvider.container)
        applicationCoordinator?.start()
        self.window = window
        return true
    }
}

