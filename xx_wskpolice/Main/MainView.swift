//
//  MainView.swift
//  xx_wskpolice
//
//  Created by Daniel Krivelev on 24.01.2022.
//

import SwiftUI

class MainViewModel: ObservableObject {
  @Published var name = "Daniel"
}

struct MainView: View {
  var isNavigationBarHidden = true
  
  @StateObject var viewModel = MainViewModel()
  
  var body: some View {
    NavigationView {
      GeometryReader { screen in
        ZStack {
          VStack {
            List {
              NavigationLink {
                
              } label: {
                HStack {
                  Image("Shield")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                  Text("Department")
                }
                
              }
              
              NavigationLink {
                
              } label: {
                HStack {
                  Image("Face")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                  Text("Wanted")
                }
                
              }
              
              NavigationLink {
                PhotoRobotsView()
              } label: {
                HStack {
                  Image("Finder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                  Text("PhotoRobot")
                }
              }
             
              
              NavigationLink {
                PaintView()
              } label: {
                
                  HStack {
                    Image("Pencil")
                      .resizable()
                      .scaledToFit()
                      .frame(width: 35, height: 35)
                    Text("Paint")
                  }
                
              }
              
              Spacer(minLength: screen.size.height / 3)
              
              NavigationLink {
                AboutUs()
              } label: {
                
                  HStack {
                    Image("ShieldWithQuestionMark")
                      .resizable()
                      .scaledToFit()
                      .frame(width: 35, height: 35)
                    Text("About Us")
                  }
                
              }
              
              
              
              
            }
            
          }
        }
        
        
        
      }
    }
  }
}


struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}

