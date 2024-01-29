//
//  UIView+Autolayout.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-28.
//

import Foundation
import UIKit

extension UIView {
  func pin(to view: UIView) {
    NSLayoutConstraint.activate([
      leadingAnchor.constraint(equalTo: view.leadingAnchor),
      trailingAnchor.constraint(equalTo: view.trailingAnchor),
      topAnchor.constraint(equalTo: view.topAnchor),
      bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}

