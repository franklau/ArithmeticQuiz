//
//  CAGradientLayer+Theme.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-27.
//

import Foundation
import UIKit

extension CAGradientLayer {
  static func makeGradientLayer() -> CAGradientLayer {
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor(rgb: 0x3FA8D3).cgColor, UIColor(rgb: 0xABCBEB).cgColor]
    return gradient
  }
}
