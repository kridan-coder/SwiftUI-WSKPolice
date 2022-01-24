//
//  Checkbox.swift
//  xx_wskpolice
//
//  Created by Daniel Krivelev on 24.01.2022.
//

import SwiftUI

struct Checkbox: View {
  @State var isChecked = false
  var body: some View {
    Image(systemName: isChecked ? "checkmark.square.fill" : "square")
      .onTapGesture {
        withAnimation {
          isChecked.toggle()
        }
      }
  }
}

struct Checkbox_Previews: PreviewProvider {
  static var previews: some View {
    Checkbox(isChecked: false)
  }
}
