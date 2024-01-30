//
//  ArithmeticOperation.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-26.
//

import Foundation
import UIKit

enum ArithmeticOperation: String {
  
  case add
  case subtract
  case multiply
  case divide
  
  enum SymbolType {
    case normal
    case outline
  }
  
  enum Level: String {
    case easy
    case medium
    case hard
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
  
  func generateNumbersForLevel(level: Level) -> (Int, Int) {
    let range = getNumberRangeForLevel(level)

    switch self {
    
    // by convention lhs should be larger that rhs
    case .add, .multiply:
      let randomNumber1 = Int.random(in: range)
      let randomNumber2 = Int.random(in: range)
      
      if randomNumber1 > randomNumber2 {
        return (randomNumber1, randomNumber2)
      } else {
        return (randomNumber2, randomNumber1)
      }
      
    // lhs must be larger than rhs
    case .subtract:
      let rhs = Int.random(in: range)
      let lhs = rhs + Int.random(in: range)
      return (lhs, rhs)
    case .divide:
      let rhs = Int.random(in: range)
      let lhs = rhs * Int.random(in: range)
      return (lhs, rhs)
    }
  }
  
  func evaluate(lhs: Int, rhs: Int) -> Int {
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
  
  private func getNumberRangeForLevel(_ level: ArithmeticOperation.Level) -> ClosedRange<Int> {
    switch level {
    case .easy:
      return 1...9
    case .medium:
      return 1...99
    case .hard:
      return 1...999
    }
  }
}

