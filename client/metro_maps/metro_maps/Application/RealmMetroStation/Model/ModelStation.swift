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
class ModelStationName: Object {
    @objc dynamic var id = ""
    @objc dynamic var nameStation = ""
    convenience init(id : String,nameStation : String) {
        self.init()
        self.id = id
        self.nameStation = nameStation
    }
  }

class ModelStationExit: Object {
    @objc dynamic var nameStation = ""
    @objc dynamic var nameExitStation = ""
    @objc dynamic var eventStation = ""
    @objc dynamic var lattitude = 0.0
    @objc dynamic var longitude = 0.0
    convenience init(nameStation: String,nameExitStation : String,eventStation: String,lattitude : Double, longitude : Double ) {
        self.init()
        self.nameStation = nameStation
        self.nameExitStation = nameExitStation
        self.eventStation = eventStation
        self.lattitude = lattitude
        self.longitude = longitude
    }
  }
