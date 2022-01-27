//
//  PhotoRobotCreateView.swift
//  xx_wskpolice
//
//  Created by Daniel Krivelev on 25.01.2022.
//

import SwiftUI
import UIKit

struct ImageResizable: View {
  init(_ imageName: String) {
    name = imageName
  }
  var name: String
  var body: some View {
    Image(name)
      .resizable()
  }
}

struct PhotoRobotCreateView: View {
  
  var topImages: [ImageResizable]
  var middleImages: [ImageResizable]
  var bottomImages: [ImageResizable]
  
  @State var currentTopPage = 0
  @State var currentMiddlePage = 0
  @State var currentBottomPage = 0
  
  var body: some View {
    VStack(spacing: 0) {
      PageViewWithButtons(pages: topImages, currentPage: currentTopPage)
      PageViewWithButtons(pages: middleImages, currentPage: currentMiddlePage)
      PageViewWithButtons(pages: bottomImages, currentPage: currentBottomPage)
    }
  }
}


struct PhotoRobotCreateView_Previews: PreviewProvider {
  static var previews: some View {
    PhotoRobotCreateView(topImages: [ImageResizable("ugly_top"), ImageResizable("vampire_top"), ImageResizable("whistle_top")], middleImages: [ImageResizable("ugly_middle"), ImageResizable("vampire_middle"), ImageResizable("whistle_middle")], bottomImages: [ImageResizable("ugly_bottom"), ImageResizable("vampire_bottom"), ImageResizable("whistle_bottom")]).frame(width: 300, height: 300)
  }
}

struct PageView<Page: View>: View {
  var pages: [Page]
  
  @State var currentPage = 0
  
  var body: some View {
    HStack {
      
    }
  }
}



struct PageViewWithButtons<Page: View>: View {
  var pages: [Page]
  
  @State var currentPage: Int
  
  var body: some View {
    ZStack {
      TabView(selection: $currentPage) {
        ForEach(0..<pages.count) { index in
          pages[index]
        }
      }
      .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
      
    
      HStack {
        if currentPage - 1 >= 0 {
          Button {
            withAnimation {
              currentPage = currentPage - 1 < 0 ? pages.count - 1 : currentPage - 1
            }
          } label: {
            Image("BackArrow")
          }
        }

        Spacer()
          .allowsHitTesting(false)
        
        if currentPage + 1 < pages.count {
          Button {
            withAnimation {
              currentPage = currentPage + 1 >= pages.count ? 0 : currentPage + 1
            }
          } label: {
            Image("NextArrow")
          }
        }

      }
      
      
      
      
    }
    
  }
}
