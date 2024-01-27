//
//  UIColor+Theme.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-26.
//

import Foundation
import UIKit

extension UIColor {
  
  static var primaryBackground: UIColor {
    return UIColor(rgb: 0x4A90E2)
  }
  
  static var navBackground: UIColor {
    return UIColor(rgb: 0x40C3C2)
  }
  
  static var navTextColor: UIColor {
    return UIColor(rgb: 0x4A4A4A)
  }
  
  static var primaryButton: UIColor {
    return UIColor(rgb: 0x50E3C2)
  }
  
  static var primaryButtonText: UIColor {
    return UIColor(rgb: 0x4A4A4A)
  }
  
  convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
