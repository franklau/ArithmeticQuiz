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
  let context = CoreDataManager.shared.mainContent
  
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
    do {
      let quizSettings = try QuizSettings.fetchOrCreateQuizSetting(operation:operation, context: context)
      let arithmeticOperationViewController = ArithmeticOperationViewController(operation: operation, quizSettings: quizSettings)
      arithmeticOperationViewController.delegate = self
      rootViewController.pushViewController(arithmeticOperationViewController, animated: true)
    } catch let error {
      fatalError("Could not fetch quiz settings \(error)")
    }
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
    do {
      let quizSetting = try QuizSettings.fetchOrCreateQuizSetting(operation: operation, context: context)
      let settingsOptionsVC = SettingsOptionsViewController(quizSettings: quizSetting, context: context)
      rootViewController.pushViewController(settingsOptionsVC, animated: true)
    } catch let error {
      print("cannnot fetch quiz setting \(error)")
    }
  }
}
