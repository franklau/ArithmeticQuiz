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
  
  enum SymbolType {
    case normal
    case outline
  }
  
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
  
  func getSymbolFor( configuration: UIImage.Configuration, symbolType: SymbolType = .normal) -> UIImage {
    var systemName: String
    switch self {
      case .add:
      systemName = "plus"
    case .subtract:
      systemName = "minus"
    case .multiply:
      systemName = "multiply"
    case .divide:
      systemName = "divide"
    }
    if symbolType == .outline {
      systemName += ".circle"
    }
    return UIImage(systemName: systemName, withConfiguration: configuration)!
  }
}

