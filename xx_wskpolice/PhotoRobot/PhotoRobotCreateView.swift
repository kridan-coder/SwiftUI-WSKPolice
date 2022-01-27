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
      PageViewController(pages: pages, currentPage: $currentPage)
      ScrollViewReader { proxy in
        ScrollView(.horizontal, showsIndicators: false) {
          ForEach(0..<pages.count, id: \.self) { index in
            pages[index]
          }
        }
        .onChange(of: currentPage) { newValue in
          proxy.scrollTo(newValue)
        }
        
        
      }
      HStack {
        Button("Previous") {
          currentPage = currentPage + 1 >= pages.count ? 0 : currentPage + 1
        }
        Spacer()
          .allowsHitTesting(false)
        Button("Next") {
          currentPage = currentPage - 1 < 0 ? pages.count - 1 : currentPage - 1
        }
      }
      
      
      
      
    }
    
  }
}

struct PageViewController<Page: View>: UIViewControllerRepresentable {
  
  var pages: [Page]
  
  @Binding var currentPage: Int
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  func makeUIViewController(context: Context) -> UIPageViewController {
    let controller = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    controller.dataSource = context.coordinator
    controller.delegate = context.coordinator
    return controller
  }
  
  func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
    var safeCurrentPage = currentPage
    if safeCurrentPage >= context.coordinator.controllers.count {
      safeCurrentPage = 0
    } else if safeCurrentPage < 0 {
      safeCurrentPage = context.coordinator.controllers.count - 1
    }
    
    
    currentPage = safeCurrentPage
    
    uiViewController.setViewControllers(
      [context.coordinator.controllers[safeCurrentPage]], direction: .forward, animated: true)
    
    
  }
  
  class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var parent: PageViewController
    var controllers = [UIViewController]()
    
    init(_ pageViewController: PageViewController) {
      parent = pageViewController
      controllers = parent.pages.map { UIHostingController(rootView: $0) }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
      guard let index = controllers.firstIndex(of: viewController) else {
        return nil
      }
      if index == 0 {
        return controllers.last
      }
      return controllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
      guard let index = controllers.firstIndex(of: viewController) else {
        return nil
      }
      if index == controllers.count - 1 {
        return controllers.first
      }
      return controllers[index + 1]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
      if completed,
         let visibleViewController = pageViewController.viewControllers?.first,
         let index = controllers.firstIndex(of: visibleViewController) {
        parent.currentPage = index
        print(parent.currentPage)
      }
    }
    
    
    
    
  }
  
}
