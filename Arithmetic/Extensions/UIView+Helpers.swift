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
  
// https://stackoverflow.com/questions/31582222/how-to-take-screenshot-of-a-uiview-in-swift
  func takeScreenshot() -> UIImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
    
    drawHierarchy(in: self.bounds, afterScreenUpdates: true)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image!
  }
}

