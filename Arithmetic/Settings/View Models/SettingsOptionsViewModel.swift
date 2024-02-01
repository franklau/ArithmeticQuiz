//
//  SettingsOptionsViewModel.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-31.
//

import Foundation

class SettingsOptionsViewModel: ObservableObject {
  @Published var level: ArithmeticOperation.Level
  @Published var duration: Int
  
  init(level: ArithmeticOperation.Level, duration: Int) {
    self.level = level
    self.duration = duration
  }
}
