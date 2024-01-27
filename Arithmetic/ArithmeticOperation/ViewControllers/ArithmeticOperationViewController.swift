//
//  ArithmeticOperationViewController.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-27.
//

import Foundation
import UIKit

class ArithmeticOperationViewController: UIViewController {

  let operation: ArithmeticOperation
  
  private lazy var gradient = {
    CAGradientLayer.makeGradientLayer()
  }()
  
  init(operation: ArithmeticOperation) {
    self.operation = operation
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.layer.insertSublayer(gradient, at: 0)
    
    let configuration = UIImage.SymbolConfiguration(font:
                                                      UIFont.systemFont(ofSize: 50, weight: .bold))
    
    let symbol = operation.getSymbolFor(configuration: configuration)
    let operationView = OperationView(lhs: "10", rhs: "1", symbol: symbol)
    operationView.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(operationView)
    NSLayoutConstraint.activate([
      operationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      operationView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    view.addSubview(operationView)
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    gradient.frame = view.bounds
  }
}
