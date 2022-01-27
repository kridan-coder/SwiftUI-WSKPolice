//
//  PhotoRobotCreateView.swift
//  xx_wskpolice
//
//  Created by Daniel Krivelev on 25.01.2022.
//

import SwiftUI
import UIKit
import RealmSwift

struct ImageResizable: View {
  init(_ imageName: String) {
    name = imageName
  }
  var name: String
  var body: some View {
    Image(uiImage: (UIImage(named: name) ?? UIImage()))
      .resizable()
  }
}

final class PhotoRobotCreateViewModel: ObservableObject {
  @Published var topImageNames: [String]
  @Published var middleImages: [String]
  @Published var bottomImages: [String]
  
  init() {
    topImageNames = PhotoRobotCreateViewModel.getImagePathsWithSufffix("_top")
    middleImages = PhotoRobotCreateViewModel.getImagePathsWithSufffix("_middle")
    bottomImages = PhotoRobotCreateViewModel.getImagePathsWithSufffix("_bottom")
  }
  
  private static func getImagePathsWithSufffix(_ suffix: String) -> [String] {
    var result = [String]()
    (Bundle.main.paths(forResourcesOfType: "png", inDirectory: nil) as NSArray).enumerateObjects({ obj, idx, stop in
      guard let safeObj = obj as? NSString else { return }
      let path = safeObj.lastPathComponent
      if path.hasSuffix(suffix + ".png") {
        result.append(path)
      }
    })
    return result
  }
}

//
//(Bundle.main.paths(forResourcesOfType: "png", inDirectory: "PhotoRobots") as NSArray).enumerateObjects({ obj, idx, stop in
//  guard let safeObj = obj as? NSString else { return }
//  let path = safeObj.lastPathComponent
//  if path.hasSuffix(suffix) {
//    result.append(path)
//  }
//})
struct PhotoRobotCreateView: View {
  
  let viewModel = PhotoRobotCreateViewModel()
  
  
  @ObservedResults(PhotoRobot.self) var content
  
  var topImages: [ImageResizable]
  var middleImages: [ImageResizable]
  var bottomImages: [ImageResizable]
  
  init() {
    topImages = viewModel.topImageNames.map { ImageResizable($0) }
    middleImages = viewModel.middleImages.map { ImageResizable($0) }
    bottomImages = viewModel.bottomImages.map { ImageResizable($0) }
  }
  
  @State var currentTopPage = 0
  @State var currentMiddlePage = 0
  @State var currentBottomPage = 0
  
  var body: some View {
    VStack(spacing: 0) {
      Spacer()
      Group {
        PageViewWithButtons(pages: topImages, currentPage: $currentTopPage)
        PageViewWithButtons(pages: middleImages, currentPage: $currentMiddlePage)
        PageViewWithButtons(pages: bottomImages, currentPage: $currentBottomPage)
      }
      .aspectRatio(3, contentMode: .fit)
      .padding(.leading).padding(.trailing)
      Spacer()
      Button("Save") {
        let photo = PhotoRobot()
        photo.bottomPath = bottomImages[currentBottomPage].name
        photo.middlePath = middleImages[currentMiddlePage].name
        photo.topPath = topImages[currentTopPage].name
        $content.append(photo)
      }
      Spacer()
    }
  }
}


struct PhotoRobotCreateView_Previews: PreviewProvider {
  static var previews: some View {
    PhotoRobotCreateView()
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
  
  @Binding var currentPage: Int
  
  
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
