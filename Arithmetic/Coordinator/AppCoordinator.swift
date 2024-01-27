//
//  AppCoordinator.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-26.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
  let window: UIWindow
  let rootViewController: UINavigationController
  
  init(window: UIWindow) {
    self.window = window
    let homeVC = HomeViewController()
    rootViewController = UINavigationController(rootViewController: homeVC)
  }
  
  func start() {
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
  }
  
}
