//
//  ArithmeticOperationViewController.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-27.
//

import Foundation
import UIKit

protocol ArithmeticOperationViewControllerDelegate: AnyObject {
  func arithmeticOperationViewControllerDidFinishWithNumCorrect(_ numCorrect: Int, numWrong: Int)
}

class ArithmeticOperationViewController: UIViewController {
  
  weak var delegate: ArithmeticOperationViewControllerDelegate?

  let operation: ArithmeticOperation
  let level = ArithmeticOperation.Level.easy
  var totalTimeInSeconds = 300.0
  
  let edgePadding = 20.0
  var operationView: OperationView!
  
  var result: Int!
  var enteredResult = "" {
    didSet {
      answerLabel.text = enteredResult
      clearButton.alpha = enteredResult == "" ? 0 : 0.5
    }
  }
  
  var numCorrect: Int = 0 {
    didSet {
      updateNumCorrectNumWrong()
    }
  }
  var numWrong: Int = 0 {
    didSet {
      updateNumCorrectNumWrong()
    }
  }
  
  var timer: Timer?
  var startTime: Date!
  private var numPadView: NumberPadView!
  
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
  
  private lazy var circularProgressView = {
   let progressView = CircularProgressView()
    progressView.translatesAutoresizingMaskIntoConstraints = false
    return progressView
  }()
  
  private lazy var countdownLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var clearButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    let configuration = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 20, weight: .bold))
    let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: configuration)
    button.setImage(image, for: .normal)
    button.tintColor = UIColor.black
    button.alpha = 0
    button.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
    return button
  }()
  
  @objc func clearTapped() {
    enteredResult = ""
  }
  
  
  init(operation: ArithmeticOperation) {
    self.operation = operation
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  private func setupUI() {
    view.layer.insertSublayer(gradient, at: 0)
    
    let (operationView, result) = makeOperationViewAndResult(operation: operation, level: level)
    self.operationView = operationView
    
    self.result = result
    self.correctWrongLabel.text = "Correct: 0 Wrong: 0"

    view.addSubview(correctWrongLabel)
    view.addSubview(operationView)
    view.addSubview(dividerLine)
    
    view.addSubview(circularProgressView)
    view.addSubview(countdownLabel)
    
    countdownLabel.text = getCountdownTextForSecondsRemaining(totalTimeInSeconds)
        
    startTime = Date()
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,
                                 selector: #selector(timerElaspsed),
                                 userInfo: nil,
                                 repeats: true)
    
    NSLayoutConstraint.activate([
      
      correctWrongLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      correctWrongLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      correctWrongLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      operationView.topAnchor.constraint(equalTo: correctWrongLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
      operationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      dividerLine.topAnchor.constraint(equalTo: operationView.bottomAnchor, constant: 10),
      dividerLine.leadingAnchor.constraint(equalTo: operationView.leadingAnchor, constant: -10),
      dividerLine.trailingAnchor.constraint(equalTo: operationView.trailingAnchor, constant: 10),
      
      circularProgressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
      circularProgressView.topAnchor.constraint(equalTo: operationView.topAnchor),
      circularProgressView.widthAnchor.constraint(equalToConstant: 50),
      circularProgressView.heightAnchor.constraint(equalToConstant: 50),
      
      countdownLabel.centerXAnchor.constraint(equalTo: circularProgressView.centerXAnchor),
      countdownLabel.topAnchor.constraint(equalTo: circularProgressView.bottomAnchor, constant: 10)
    ])
    
    view.addSubview(answerLabel)
    view.addSubview(clearButton)
    NSLayoutConstraint.activate([
      answerLabel.trailingAnchor.constraint(equalTo: dividerLine.trailingAnchor),
      answerLabel.topAnchor.constraint(equalTo: dividerLine.topAnchor, constant: 20),
      clearButton.leadingAnchor.constraint(equalTo: answerLabel.trailingAnchor, constant: 10),
      clearButton.centerYAnchor.constraint(equalTo: answerLabel.centerYAnchor)
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
  
  @objc func timerElaspsed() {
    let timeElapsed = Date().timeIntervalSince(startTime)
    let totalTimeInSeconds = CGFloat(totalTimeInSeconds)
    if totalTimeInSeconds > timeElapsed {
      let timeRemaining = totalTimeInSeconds - timeElapsed
      let fractionalProgress = timeRemaining / totalTimeInSeconds
      circularProgressView.updateProgress(fractionalProgress)
      countdownLabel.text = getCountdownTextForSecondsRemaining(timeRemaining)
    } else {
      clearTimer()
      circularProgressView.updateProgress(0)
      countdownLabel.text = getCountdownTextForSecondsRemaining(0.0)
      delegate?.arithmeticOperationViewControllerDidFinishWithNumCorrect(numCorrect, numWrong: numWrong)
    }
  }
  
  private func getCountdownTextForSecondsRemaining(_ secondsRemaining: Double) -> String {
    let secondsRemaining = Int(secondsRemaining)
    let minute = secondsRemaining / 60
    let seconds = secondsRemaining % 60
    return String(String(format: "%02d : %02d", minute, seconds))
  }
  
  private func clearTimer() {
    timer?.invalidate()
    timer = nil
  }
  
  deinit {
    clearTimer()
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
    if Int(enteredResult) == result {
      numCorrect += 1
    } else {
      numWrong += 1
    }
    self.view.isUserInteractionEnabled = false
    enteredResult = ""
    let configuration = UIImage.SymbolConfiguration(font: UIConstants.arithmeticOperationFont)
    let symbol = operation.getSymbolFor(configuration: configuration)
    let (lhs, rhs) = operation.generateNumbersForLevel(level: .easy)
    operationView.update(lhs: String(lhs), rhs: String(rhs), symbol: symbol) {
      self.result = self.operation.evaluate(lhs: lhs, rhs: rhs)
      self.view.isUserInteractionEnabled = true
    }
  }
  
  private func updateNumCorrectNumWrong() {
    self.correctWrongLabel.text = "Correct: \(numCorrect) Wrong: \(numWrong)"
  }
}
