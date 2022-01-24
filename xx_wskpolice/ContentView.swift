//
//  ContentView.swift
//  xx_wskpolice
//
//  Created by Daniel Krivelev on 24.01.2022.
//

import SwiftUI

struct ContentView: View {
  
  @AppStorage("isLoggedIn") var isLoggedIn = false
  
  @State var enteredAsGuest = false
  
  var body: some View {
    if enteredAsGuest || isLoggedIn {
      MainView()
    } else {
      LoginView(enteredAsGuest: $enteredAsGuest)
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
