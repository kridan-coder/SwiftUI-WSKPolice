//
//  LoginView.swift
//  xx_wskpolice
//
//  Created by Daniel Krivelev on 24.01.2022.
//

import SwiftUI

class LoginViewModel: ObservableObject {
  @Published var name = "Daniel"
  
  @Published var login = ""
  @Published var password =  ""
  @Published var captcha =  ""
  
  @Published var captchaTextCheck: [Character]
  
  var captchaTextReal: String {
    var result = ""
    for character in captchaTextCheck {
      result.append(String(character))
    }
    return result
  }
  
  static func randomCharacters(length: Int = 3) -> [Character] {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return [Character]((0..<length).map{ _ in letters.randomElement()! })
  }
  
  init() {
    captchaTextCheck = LoginViewModel.randomCharacters()
  }

  
}

struct LoginView: View {
  
  @AppStorage("isLoggedIn") var isLoggedIn: Bool?
  
  @Binding var enteredAsGuest: Bool
  
  var isNavigationBarHidden = true
  @State var needsCaptcha = true
  @State var needsAlert = false
  
  @StateObject var viewModel = LoginViewModel()
  
  var body: some View {
    NavigationView {
      GeometryReader { screen in
        VStack(alignment: .center) {
          Image("Icon")
            .resizable()
            .frame(width: 100, height: 100)
            .padding(.top, 40)
          Image("WSKPolice")
            .resizable()
            .scaledToFit()
            .frame(width: screen.size.width * 0.8, height: 50)
            .padding(.top, 10)
          HStack(alignment: .center) {
            Image("Login")
              .resizable()
              .frame(width: 40, height: 40)
            
            GeometryReader { textField in
              VStack {
                TextField("Login", text: $viewModel.login)
                  .font(.custom("Scada-Regular", size: 20))
                Rectangle()
                  .frame(width: textField.size.width, height: 1)
                
              }
              
            }
            .frame(height: 40)
            
          }
          .padding(.leading, 30).padding(.trailing, 30)
          .padding(.top, 15)
          HStack(alignment: .center) {
            Image("Password")
              .resizable()
              .frame(width: 40, height: 40)
            
            GeometryReader { textField in
              VStack {
                SecureField("Password", text: $viewModel.password)
                  .font(.custom("Scada-Regular", size: 20))
                Rectangle()
                  .frame(width: textField.size.width, height: 1)
                
              }
              
            }
            .frame(height: 40)
            
          }
          .padding(.leading, 30).padding(.trailing, 30)
          .padding(.top, 15)
          
          HStack {
            Checkbox()
            Text("Remember me")
              .font(.custom("Scada-Regular", size: 16))
          }
          Spacer()
          if needsCaptcha {
            Group {
              VStack(alignment: .center) {
                Text("Enter captcha:")
                  .font(.custom("Scada-Regular", size: 18))
                Captcha(textInCharacters: $viewModel.captchaTextCheck)
                  .padding(.bottom, 20)
                TextField("Enter captcha", text: $viewModel.captcha)
                  .multilineTextAlignment(.center)
                  .frame(width: 200)
                Rectangle()
                  .frame(width: 200, height: 1)
                Button {
                  if viewModel.captcha == viewModel.captchaTextReal {
                    withAnimation {
                      needsCaptcha = false
                    }
                    
                  } else {
                    viewModel.captchaTextCheck = LoginViewModel.randomCharacters()
                    viewModel.captcha = ""
                    needsAlert = true
                    
                  }
                } label: {
                  Text("OK")
                    .frame(maxWidth: .infinity)
                    .font(.custom("Scada-Regular", size: 20))
                    .foregroundColor(.white)
                }
                .frame(width: 100, height: 40)
                .background(Color("ButtonColor"))
                .padding()
                .alert("Incorrect Captcha input. Try again.", isPresented: $needsAlert) {}
                
              }
            }
          } else {
            // buttons
            Group {
              Button {
                
              } label: {
                Text("SignIn")
                  .frame(maxWidth: .infinity)
                  .font(.custom("Scada-Regular", size: 20))
                  .foregroundColor(.white)
              }
              .frame(width: 225, height: 50)
              .background(Color("ButtonColor"))
              .padding()
              
              Button {
                withAnimation {
                  
                  enteredAsGuest.toggle()
                }
              } label: {
                Text("Guest")
                  .frame(maxWidth: .infinity)
                  .font(.custom("Scada-Regular", size: 20))
                  .foregroundColor(.white)
              }
              .frame(width: 225, height: 50)
              .background(Color("ButtonColor"))
            }
          }
          
          Spacer()
          
          
        }
      }
      .navigationBarHidden(isNavigationBarHidden)
    }
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView(enteredAsGuest: .constant(false))
  }
}

