//
//  OperationView.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-27.
//

import Foundation
import UIKit

class OperationView: UIStackView {
  
  private let font = UIConstants.arithmeticOperationFont
  private let textColor = UIColor.primaryButtonText
  private var lhsLabel: UILabel!
  private var rhsLabel: UILabel!
  
  init(lhs: String, rhs: String, symbol: UIImage) {
    super.init(frame: .zero)
    axis = .horizontal
    alignment = .fill
    let numberStack = UIStackView.makeVerticalStack()
    lhsLabel = makeLabelWithText(lhs)
    rhsLabel = makeLabelWithText(rhs)
    numberStack.addArrangedSubview(lhsLabel)
    numberStack.addArrangedSubview(rhsLabel)
    imageView.image = symbol
    let operationStack = UIStackView.makeVerticalStack()
    let spacer = UIView()
    operationStack.addArrangedSubview(spacer)
    operationStack.addArrangedSubview(imageView)
    addArrangedSubview(operationStack)
    addArrangedSubview(numberStack)
  }
  
  func update(lhs: String, rhs: String, symbol: UIImage, completion: (() -> Void)?) {
    let screenshot = self.takeScreenshot()
    let tempView = UIImageView(frame: CGRect(origin: .zero , size: screenshot.size))
    tempView.image = screenshot
    tempView.translatesAutoresizingMaskIntoConstraints = false
    
    self.addSubview(tempView)
    
    tempView.pin(to: self)
  
    showUIElements(false)
    
    lhsLabel.text = lhs
    rhsLabel.text = rhs
    imageView.image = symbol
    
    UIView.animate(withDuration: 0.5, delay: 0, animations: {
      
      self.showUIElements(true)
      tempView.alpha = 0
    }, completion: { _ in
      tempView.removeFromSuperview()
      completion?()
    })
}
  
  private func showUIElements(_ show: Bool) {
    self.lhsLabel.alpha = show ? 1 : 0
    self.rhsLabel.alpha = show ? 1 : 0
    self.imageView.alpha = show ? 1 : 0
  }
  
  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.tintColor = textColor
    return imageView
  }()
  
  private func makeLabelWithText(_ text: String) -> UILabel {
    let label = UILabel(frame: .zero)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = font
    label.text = text
    label.textAlignment = .right
    label.textColor = textColor
    return label
  }
  
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
