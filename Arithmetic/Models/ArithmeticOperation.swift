//
//  ArithmeticOperation.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-26.
//

import Foundation
import UIKit

enum ArithmeticOperation {
  
  case add
  case subtract
  case multiply
  case divide
  
  func performOperation(lhs: Int, rhs: Int) -> Int {
    switch self {
    case .add:
      return lhs + rhs
    case .subtract:
      return lhs - rhs
    case .multiply:
      return lhs * rhs
    case .divide:
      return lhs / rhs
    }
  }
  
  func getSymbolFor( configuration: UIImage.Configuration) -> UIImage {
    let systemName: String
    switch self {
      case .add:
      systemName = "plus.circle"
    case .subtract:
      systemName = "minus.circle"
    case .multiply:
      systemName = "multiply.circle"
    case .divide:
      systemName = "divide.circle"
    }
    return UIImage(systemName: systemName, withConfiguration: configuration)!
  }
}

