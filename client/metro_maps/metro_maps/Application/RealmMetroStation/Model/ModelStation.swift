//
//  ModelStation.swift
//  metro_maps
//
//  Created by Artem Stratienko on 31.10.2020.
//

import UIKit
import RealmSwift

class ModelStation: Object {
    @objc dynamic var id = ""
    @objc dynamic var nameStation = ""
    @objc dynamic var lineID = ""
    convenience init(id : String,nameStation : String, lineID : String) {
        self.init()
        self.id = id
        self.nameStation = nameStation
        self.lineID = lineID
    }
  }
class ModelLine : Object {
    @objc dynamic var id = ""
    @objc dynamic var nameLine = ""
    convenience init(id : String,nameLine : String) {
        self.init()
        self.id = id
        self.nameLine = nameLine
    }
}
class ModelPath : Object {
    @objc dynamic var id = ""
    @objc dynamic var staionIDStart = ""
    @objc dynamic var staionIDEnd = ""
    convenience init(id : String,staionIDStart : String,staionIDEnd : String) {
        self.init()
        self.id = id
        self.staionIDStart = staionIDStart
        self.staionIDEnd = staionIDEnd
    }
}
