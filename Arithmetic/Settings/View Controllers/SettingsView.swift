//
//  SettingsView.swift
//  Arithmetic
//
//  Created by Frank Lau on 2024-01-31.
//

import SwiftUI

struct SettingsView: View {
      
  var operations: [ArithmeticOperation] = [.add, .subtract, .multiply, .divide]
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
        Text("Please select an option")
          .font(Font.system(size: 30))
          .padding([.bottom, .top], 30)
        VStack(alignment: .leading) {
          ForEach(operations) { operation in
            VStack(alignment: .leading, spacing: 0) {
              Button {
                print("button")
              } label: {
                HStack { // use HStack so tap area of button is the width of the gray
                  Text(operation.buttonText)
                    .font(Font.system(size: 20, weight: .medium))
                    .foregroundColor(Color(UIColor.secondaryButton))
                    .padding()
                  Spacer()
                  Image(systemName: "chevron.right")
                    .padding(.trailing, 10)
                    .foregroundColor(Color(UIColor.secondaryButton))
                }
              }
              Divider()
            }
          }
        }
        .background(Color(UIColor.lightGray))
        .cornerRadius(10)
        Spacer()
      }
      .padding(.horizontal, 20)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
