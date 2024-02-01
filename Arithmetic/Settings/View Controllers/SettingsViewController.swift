//
//  SettingsViewController.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-31.
//

import UIKit
import SwiftUI

protocol SettingsViewControllerDelegate: AnyObject {
  func userSelectedOperationSetting(operation: ArithmeticOperation)
}

class SettingsViewController: UIViewController {
  
  var operations: [ArithmeticOperation] = [.add, .subtract, .multiply, .divide]
  var tapHandler: ((ArithmeticOperation) -> Void)!
  weak var delegate: SettingsViewControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  private func setupUI() {
    tapHandler = { [weak self] operation in
      guard let self = self else { return }
      self.delegate?.userSelectedOperationSetting(operation: operation)
    }
    let settingsView = SettingsView(tapHandler: tapHandler)
    let hostViewController = UIHostingController(rootView: settingsView)
    let hostView = hostViewController.view!
    hostView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(hostView)
    
    NSLayoutConstraint.activate([
      hostView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      hostView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      hostView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      hostView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    navigationItem.title = "Settings"
  }
}
