//
//  SettingOptionsView.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-31.
//

import SwiftUI

struct SettingOptionsView: View {
    
  @ObservedObject var viewModel: SettingsOptionsViewModel
  var changeHandler: (SettingsOptionsViewModel) -> Void
  
  var levels: [ArithmeticOperation.Level] = [.easy, .medium, .hard]
  var body: some View {
    VStack(alignment: .leading) {
      ForEach(levels) { level in
        HStack {
          Text("\(level.rawValue.capitalized)")
          Spacer()
          Image(systemName: viewModel.level == level ? "circle.fill" : "circle")
            .foregroundColor(Color.red)
        }
        .contentShape(Rectangle())
        .onTapGesture {
          viewModel.level = level
          changeHandler(viewModel)
        }
        .padding(.vertical, 10)
        Divider()
      }
      Text("Quiz Length")
        .padding(.top, 20)
      Picker("Quiz Duration", selection: $viewModel.duration) {
        ForEach(Constants.quizDurationOptions, id: \.self) {
          Text("\($0) seconds")
            .accentColor(Color(UIColor.secondaryButton))
        }
      }
      .padding(.leading, -10)
      Spacer()
    }
    .padding()
    .onChange(of: viewModel.duration) { change in
      changeHandler(viewModel)
    }
  }
}

struct SettingOptionsView_Previews: PreviewProvider {
    static var previews: some View {
      let viewModel = SettingsOptionsViewModel(level: .easy, duration: 20)
      SettingOptionsView(viewModel: viewModel) { _ in }
    }
}
