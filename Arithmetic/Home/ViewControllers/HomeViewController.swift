//
//  HomeViewController.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-26.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
  func userSelectedOperation(operation: ArithmeticOperation)
}

class HomeViewController: UIViewController {
  
  weak var delegate: HomeViewControllerDelegate?
  
  @IBOutlet weak var menuStackView: UIStackView!
  
  var operations: [ArithmeticOperation] = [.add, .subtract, .multiply, .divide]
  
  private lazy var gradient = {
    CAGradientLayer.makeGradientLayer()
  }()
  
  private lazy var settingsButton: HomeButton = {
    let config = UIImage.SymbolConfiguration(font: UIConstants.homePageButtonFont)
    let image = UIImage(systemName: "gear", withConfiguration: config)!
    let button = HomeButton(title: "Setting", image: image, buttonBGColor: UIColor.secondaryButton)
    button.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    operations.forEach {
      let configuration = UIImage.SymbolConfiguration(font: UIConstants.homePageButtonFont)
      let symbol = $0.getSymbolFor(configuration: configuration, symbolType: .outline)
      let button = HomeButton(title: $0.buttonText, image: symbol)
      button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
      menuStackView.addArrangedSubview(button)
    }
    menuStackView.addArrangedSubview(settingsButton)
    view.layer.insertSublayer(gradient, at: 0)
    navigationItem.title = "Menu"
  }
  
  @objc func buttonTapped(_ button: UIButton) {
    let index = menuStackView.arrangedSubviews.firstIndex(of: button)
    guard let index = index else { return }
    let operation = operations[index]
    delegate?.userSelectedOperation(operation: operation)
  }
  
  @objc func settingsTapped() {
      print("settings")
  }
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    gradient.frame = view.bounds
  }
}

extension ArithmeticOperation {
  
  var buttonText: String {
    switch self {
    case .add:
      return "Add"
    case .subtract:
      return "Subtract"
    case .multiply:
      return "Multiply"
    case .divide:
      return "Divide"
    }
  }
  
}

