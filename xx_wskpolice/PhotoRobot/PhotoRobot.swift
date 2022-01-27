//
//  PhotoRobot.swift
//  xx_wskpolice
//
//  Created by Daniel Krivelev on 25.01.2022.
//

import Foundation
import RealmSwift

class PhotoRobot: Object, ObjectKeyIdentifiable {
  @objc dynamic var topPath = ""
  @objc dynamic var middlePath = ""
  @objc dynamic var bottomPath = ""
}
