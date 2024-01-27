//
//  HomeViewController.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-26.
//

import UIKit

class HomeViewController: UIViewController {

  @IBOutlet weak var menuStackView: UIStackView!
  
  var operations: [ArithmeticOperation] = [.add, .subtract, .multiply, .divide]
  
  private lazy var gradient = {
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor(rgb: 0x3FA8D3).cgColor, UIColor(rgb: 0xABCBEB).cgColor]
    return gradient
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    operations.forEach {
      let configuration = UIImage.SymbolConfiguration(font:
                                                UIFont.systemFont(ofSize: 30, weight: .bold))
      let symbol = $0.getSymbolFor(configuration: configuration)
      let button = HomeButton(title: $0.buttonText, image: symbol)
      menuStackView.addArrangedSubview(button)
    }
    view.layer.insertSublayer(gradient, at: 0)
    navigationItem.title = "Menu"
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

