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
  let edgePadding = 20.0
  var operationView: OperationView!
  
  var result: Int!
  var enteredResult = "" {
    didSet {
      answerLabel.text = enteredResult
    }
  }
  
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
  
  private lazy var answerLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
    label.textColor = UIColor.primaryButtonText
    return label
  }()
  
  private lazy var correctWrongLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
    label.textColor = UIColor.black
    return label
  }()
  
  private var numPadView: NumberPadView!
  
  init(operation: ArithmeticOperation) {
    self.operation = operation
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.layer.insertSublayer(gradient, at: 0)
    
    let (operationView, result) = makeOperationViewAndResult(operation: operation, level: level)
    self.operationView = operationView
    
    self.result = result
    self.correctWrongLabel.text = "Correct: 0 Wrong: 0"

    view.addSubview(correctWrongLabel)
    view.addSubview(operationView)
    view.addSubview(dividerLine)
    
    NSLayoutConstraint.activate([
      
      correctWrongLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      correctWrongLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      correctWrongLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      operationView.topAnchor.constraint(equalTo: correctWrongLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
      operationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      dividerLine.topAnchor.constraint(equalTo: operationView.bottomAnchor, constant: 10),
      dividerLine.leadingAnchor.constraint(equalTo: operationView.leadingAnchor, constant: -10),
      dividerLine.trailingAnchor.constraint(equalTo: operationView.trailingAnchor, constant: 10)
    ])
    
    view.addSubview(answerLabel)
    NSLayoutConstraint.activate([
      answerLabel.trailingAnchor.constraint(equalTo: dividerLine.trailingAnchor),
      answerLabel.topAnchor.constraint(equalTo: dividerLine.topAnchor, constant: 20)
    ])
        
    let screenBounds = UIScreen.main.bounds
    let width = (screenBounds.width - 2 * edgePadding)
    let height = UIScreen.main.bounds.height / 2.2
    
    let bounds = CGRect(origin: .zero, size: CGSize(width: width, height: height))
    self.numPadView = NumberPadView(bounds: bounds)
    self.numPadView.delegate = self
    self.numPadView.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(numPadView)
    
    NSLayoutConstraint.activate([
      numPadView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      numPadView.widthAnchor.constraint(equalToConstant: width),
      numPadView.heightAnchor.constraint(equalToConstant: height),
      numPadView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    gradient.frame = view.bounds
  }
  
  func makeOperationViewAndResult(operation: ArithmeticOperation,
                                  level: ArithmeticOperation.Level) -> (OperationView, Int) {
    let configuration = UIImage.SymbolConfiguration(font: UIConstants.arithmeticOperationFont)
    let symbol = operation.getSymbolFor(configuration: configuration)
    let (lhs, rhs) = operation.generateNumbersForLevel(level: .easy)
    let operationView = OperationView(lhs: String(lhs), rhs: String(rhs), symbol: symbol)
    operationView.translatesAutoresizingMaskIntoConstraints = false
    
    let result = operation.evaluate(lhs: lhs, rhs: rhs)
    return (operationView, result)
  }
}

extension ArithmeticOperationViewController: NumberPadViewDelegate {
  func numberPadDidSelect(number: Int) {
    let maxDigits = 10
    if enteredResult.count < maxDigits {
      enteredResult += String(number)
    }
    
    print("entered result \(enteredResult)")
  }
  
  func numberPadDidEnter() {
    // TODO: overlay large checkmark or x
    self.correctWrongLabel.text = "Correct: 0 Wrong: 0"
    self.view.isUserInteractionEnabled = false
    enteredResult = ""
    let configuration = UIImage.SymbolConfiguration(font: UIConstants.arithmeticOperationFont)
    let symbol = operation.getSymbolFor(configuration: configuration)
    let (lhs, rhs) = operation.generateNumbersForLevel(level: .easy)
    operationView.update(lhs: String(lhs), rhs: String(rhs), symbol: symbol) {
      self.view.isUserInteractionEnabled = true
    }
  }
}

