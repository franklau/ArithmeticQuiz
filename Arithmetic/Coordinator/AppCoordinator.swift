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
    arithmeticOperationViewController.delegate = self
    rootViewController.pushViewController(arithmeticOperationViewController, animated: true)
  }
  
  func userSelectedSettings() {
    let settingsVC = SettingsViewController()
    settingsVC.delegate = self
    rootViewController.pushViewController(settingsVC, animated: true)
  }
}

extension AppCoordinator: ArithmeticOperationViewControllerDelegate {
  func arithmeticOperationViewControllerDidFinishWithNumCorrect(_ numCorrect: Int, numWrong: Int) {
    // TODO: create game results screen
    rootViewController.popViewController(animated: false)
  }
}

extension AppCoordinator: SettingsViewControllerDelegate {
  func userSelectedOperationSetting(operation: ArithmeticOperation) {
    let settingsOptionsVC = SettingsOptionsViewController()
    rootViewController.pushViewController(settingsOptionsVC, animated: true)
//    print("operation \(operation)")
  }
}
