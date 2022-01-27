//
//  PhotoRobotsView.swift
//  xx_wskpolice
//
//  Created by Daniel Krivelev on 25.01.2022.
//

import SwiftUI
import RealmSwift

final class PhotoRobotsViewModel: ObservableObject {
}

struct PhotoRobotsView: View {
  
  
  @ObservedResults(PhotoRobot.self) var content
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem(), GridItem()], spacing: 12) {
        
        ForEach(content) { photoRobot in
          NavigationLink {
            PhotoRobotContainer(photoRobot: photoRobot)
              .padding()
          } label: {
            PhotoRobotContainer(photoRobot: photoRobot)
          }
        }
      }
    }
    
    .toolbar {
      NavigationLink {
        PhotoRobotCreateView()
      } label: {
        Text("+")
      }
    }
  }
}

struct PhotoRobotsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      PhotoRobotsView()
    }
  }
}
