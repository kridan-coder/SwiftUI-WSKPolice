//
//  PhotoRobotCreateView.swift
//  xx_wskpolice
//
//  Created by Daniel Krivelev on 25.01.2022.
//

import SwiftUI
import UIKit

fileprivate struct Image: View {
  var image: Image
  var body: some View {
    I
  }
}

struct PhotoRobotCreateView: View {
  
  var topImages: [Image]
  var middleImages: [Image]
  var bottomImages: [Image]
  
  var body: some View {
    VStack(spacing: 0) {
      PageView(pages: topImages)
      PageView(pages: middleImages)
      PageView(pages: bottomImages)
    }
  }
}

struct PhotoRobotCreateView_Previews: PreviewProvider {
  static var previews: some View {
    PhotoRobotCreateView(topImages: [Image("ugly_top"), Image("vampire_top"), Image("whistle_top")], middleImages: [Image("ugly_middle"), Image("vampire_middle"), Image("whistle_middle")], bottomImages: [Image("ugly_bottom"), Image("vampire_bottom"), Image("whistle_bottom")]).frame(width: 300, height: 300)
  }
}

struct PageView<Page: View>: View {
  var pages: [Page]
  
  var body: some View {
    PageViewController(pages: pages)
  }
}

struct PageViewController<Page: View>: UIViewControllerRepresentable {
  
  var pages: [Page]
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  
  func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
    uiViewController.setViewControllers(
      [UIHostingController(rootView: pages[0])], direction: .forward, animated: true)
    
  }
  
  
  func makeUIViewController(context: Context) -> UIPageViewController {
    UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
  }
  
  class Coordinator: NSObject, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
      guard let index = controllers.firstIndex(of: viewController) else {
          return nil
      }
      if index == controllers.count + 1 {
          return controllers.first
      }
      return controllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
      guard let index = controllers.firstIndex(of: viewController) else {
          return nil
      }
      if index == 0 {
          return controllers.last
      }
      return controllers[index - 1]
    }
    
    var parent: PageViewController
    var controllers = [UIViewController]()
    
    init(_ pageViewController: PageViewController) {
      parent = pageViewController
      controllers = parent.pages.map { UIHostingController(rootView: $0) }
    }
    
    
  }
  
}

