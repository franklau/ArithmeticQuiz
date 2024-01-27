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
  
  init(lhs: String, rhs: String, symbol: UIImage) {
    super.init(frame: .zero)
    axis = .horizontal
    alignment = .fill
    let numberStack = UIStackView.makeVerticalStack()
    let lhsLabel = makeLabelWithText(lhs)
    let rhsLabel = makeLabelWithText(rhs)
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
