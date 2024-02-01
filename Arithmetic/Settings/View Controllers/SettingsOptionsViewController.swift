//
//  SettingsOptionsViewController.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-31.
//

import UIKit
import SwiftUI

class SettingsOptionsViewController: UIViewController {

  var viewModel = SettingsOptionsViewModel(level: .easy, duration: 20)
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
  
  private func setupUI() {
    let settingOptionsView = SettingOptionsView(viewModel: viewModel)
    let hostingVC = UIHostingController(rootView: settingOptionsView)
    let hostView = hostingVC.view!
    hostView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(hostView)
    NSLayoutConstraint.activate([
      hostView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      hostView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      hostView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      hostView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}
