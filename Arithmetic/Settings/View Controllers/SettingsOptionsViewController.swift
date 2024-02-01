//
//  SettingsOptionsViewController.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-31.
//

import UIKit
import SwiftUI
import CoreData

class SettingsOptionsViewController: UIViewController {

  var viewModel: SettingsOptionsViewModel
  var settingsChangedHandler: ((SettingsOptionsViewModel) -> Void)!
  let quizSettings: QuizSettings
  var context: NSManagedObjectContext
  
  init(quizSettings: QuizSettings, context: NSManagedObjectContext) {
    self.quizSettings = quizSettings
    self.context = context
    let level =  ArithmeticOperation.Level(rawValue: quizSettings.level ?? "") ?? .easy
    self.viewModel = SettingsOptionsViewModel(level: level, duration: Int(quizSettings.durationInSeconds))
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  private func setupUI() {
    settingsChangedHandler = { [weak self]  viewModel in
      guard let self = self else { return }
      self.quizSettings.level = viewModel.level.rawValue
      self.quizSettings.durationInSeconds = Int64(viewModel.duration)
      do {
        try self.context.save()
      } catch let error {
        print("error \(error)")
      }
    }
    let settingOptionsView = SettingOptionsView(viewModel: viewModel, changeHandler: settingsChangedHandler)
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
