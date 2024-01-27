//
//  HomeButton.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-26.
//

import Foundation
import UIKit

class HomeButton: UIButton {
  
  private let cornerRadius = 12.0
  private let buttonBGColor = UIColor.primaryButton
  private let font = UIFont.systemFont(ofSize: 30, weight: .bold)
  
  private lazy var shadowLayer = {
    let layer = CAShapeLayer()
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    layer.shadowOpacity = 0.2
    layer.shadowRadius = 3
    return layer
  }()
  
  init(title: String, image: UIImage) {
    super.init(frame: .zero)
    self.setTitle(title, for: .normal)
    self.setImage(image, for: .normal)
    self.titleLabel?.font = font
    self.setTitleColor(UIColor.primaryButtonText, for: .normal)
    self.imageView?.tintColor = UIColor.primaryButtonText
    self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  override func layoutSubviews() {
    super.layoutSubviews()
    shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
  }

  private func setupUI() {
    layer.insertSublayer(shadowLayer, at: 0)
    shadowLayer.fillColor = buttonBGColor.cgColor
  }
}
