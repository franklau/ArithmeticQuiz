//
//  SettingsViewController.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-31.
//

import UIKit
import SwiftUI

class SettingsViewController: UIViewController {
  
  var operations: [ArithmeticOperation] = [.add, .subtract, .multiply, .divide]

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  private func setupUI() {
    let hostViewController = UIHostingController(rootView: SettingsView())
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
