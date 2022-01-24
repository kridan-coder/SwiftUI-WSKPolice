//
//  Captcha.swift
//  xx_wskpolice
//
//  Created by Daniel Krivelev on 24.01.2022.
//

import SwiftUI

struct Captcha: View {
  
  @Binding var textInCharacters: [Character]
  

  

  
  var body: some View {
    ZStack {
      Image("Captcha")
        .resizable()
        .scaledToFill()
        .frame(width: 100, height: 100)
      HStack(alignment: .center) {
        Group {
          Text(String(textInCharacters[0]))
            .offset(x: CGFloat.random(in: 0...2), y: CGFloat.random(in: 0...2))
            .rotationEffect(Angle.degrees(Double.random(in: -30...30)))
          Text(String(textInCharacters[1]))
            .offset(x: CGFloat.random(in: 0...2), y: CGFloat.random(in: 0...2))
            .rotationEffect(Angle.degrees(Double.random(in: -30...30)))
          Text(String(textInCharacters[2]))
            .offset(x: CGFloat.random(in: 0...2), y: CGFloat.random(in: 0...2))
            .rotationEffect(Angle.degrees(Double.random(in: -30...30)))
        }
        .foregroundColor(.purple)

      }
    }
  }
}

struct Captcha_Previews: PreviewProvider {
  static var previews: some View {
    Captcha(textInCharacters: .constant(["1", "3", "3"]))
  }
}
