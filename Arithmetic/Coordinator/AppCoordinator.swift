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
    homeVC.delegate = self
  }
  
  func start() {
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
  }
  
}

extension AppCoordinator: HomeViewControllerDelegate {
  func userSelectedOperation(operation: ArithmeticOperation) {
    let arithmeticOperationViewController = ArithmeticOperationViewController(operation: operation)
    rootViewController.pushViewController(arithmeticOperationViewController, animated: true)
  }
}
