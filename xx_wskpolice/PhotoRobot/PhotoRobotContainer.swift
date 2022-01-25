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
      Image(photoRobot.topPath)
        .resizable()
      Image(photoRobot.middlePath)
        .resizable()
      Image(photoRobot.bottomPath)
        .resizable()
    }
    .aspectRatio(1, contentMode: .fill)
    
  }
}

struct PhotoRobotContainer_Previews: PreviewProvider {
  static var previews: some View {
    PhotoRobotContainer(photoRobot: PhotoRobot(topPath: "zombie_top", middlePath: "wink_middle", bottomPath: "vampire_bottom")).frame(width: 100, height: 100)
  }
}
