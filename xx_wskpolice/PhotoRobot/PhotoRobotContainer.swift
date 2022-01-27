//
//  PhotoRobotContainer.swift
//  xx_wskpolice
//
//  Created by Daniel Krivelev on 25.01.2022.
//

import SwiftUI

struct PhotoRobotContainer: View {
  var photoRobot: PhotoRobot
  var body: some View {
    VStack(spacing: 0) {
      Image(uiImage: (UIImage(named: photoRobot.topPath) ?? UIImage()))
        .resizable()
      Image(uiImage: (UIImage(named: photoRobot.middlePath) ?? UIImage()))
        .resizable()
      Image(uiImage: (UIImage(named: photoRobot.bottomPath) ?? UIImage()))
        .resizable()
    }
    .frame(idealWidth: 100, idealHeight: 100)
    .aspectRatio(1, contentMode: .fit)
    
  }
}

struct PhotoRobotContainer_Previews: PreviewProvider {
  static var previews: some View {
    EmptyView()
  }
}
