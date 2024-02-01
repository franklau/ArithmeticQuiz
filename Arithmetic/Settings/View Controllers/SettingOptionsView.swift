//
//  SettingOptionsView.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-31.
//

import SwiftUI

struct SettingOptionsView: View {
    
  @ObservedObject var viewModel: SettingsOptionsViewModel
  
  var levels: [ArithmeticOperation.Level] = [.easy, .medium, .hard]
  var body: some View {
    VStack(alignment: .leading) {
      ForEach(levels) { level in
        HStack {
          Text("\(level.rawValue.capitalized)")
          Spacer()
          Image(systemName: viewModel.level == level ? "circle.fill" : "circle" )
            .foregroundColor(Color.red)
        }
        .contentShape(Rectangle())
        .onTapGesture {
          viewModel.level = level
        }
        .padding(.vertical, 10)
        Divider()
      }
      Spacer()
    }
    .padding()
  }
}

struct SettingOptionsView_Previews: PreviewProvider {
    static var previews: some View {
      let viewModel = SettingsOptionsViewModel(level: .easy, duration: 20)
      SettingOptionsView(viewModel: viewModel)
    }
}
