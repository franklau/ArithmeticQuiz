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
  let level = ArithmeticOperation.Level.easy
  
  private lazy var gradient = {
    CAGradientLayer.makeGradientLayer()
  }()
  
  private lazy var dividerLine: UIView = {
    let view = UIView()
    let height = 10.0
    view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      view.heightAnchor.constraint(equalToConstant: height)
    ])
    view.clipsToBounds = true
    view.layer.cornerRadius = height / 2
    view.backgroundColor = UIColor.primaryButtonText
    return view
  }()
  
  init(operation: ArithmeticOperation) {
    self.operation = operation
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.layer.insertSublayer(gradient, at: 0)
    
    let configuration = UIImage.SymbolConfiguration(font: UIConstants.arithmeticOperationFont)
    
    let symbol = operation.getSymbolFor(configuration: configuration)
    let (lhs, rhs) = operation.generateNumbersForLevel(level: .easy)
    
    print("\(operation.evaluate(lhs: lhs, rhs: rhs))")
    
    let operationView = OperationView(lhs: String(lhs), rhs: String(rhs), symbol: symbol)
    operationView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(operationView)
    view.addSubview(dividerLine)
    
    NSLayoutConstraint.activate([
      operationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
      operationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      dividerLine.topAnchor.constraint(equalTo: operationView.bottomAnchor, constant: 10),
      dividerLine.leadingAnchor.constraint(equalTo: operationView.leadingAnchor, constant: -10),
      dividerLine.trailingAnchor.constraint(equalTo: operationView.trailingAnchor, constant: 10)
    ])
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    gradient.frame = view.bounds
  }
  
  func makeOperationView(operation: ArithmeticOperation, level: ArithmeticOperation.Level) {
      
  }
}

