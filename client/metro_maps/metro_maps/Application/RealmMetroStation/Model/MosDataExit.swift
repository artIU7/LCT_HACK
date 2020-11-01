//
//  MosDataExit.swift
//  metro_maps
//
//  Created by Artem Stratienko on 01.11.2020.
//

import Foundation

struct StationExit {
    var nameStation = ""
    var nameExitStation = ""
    var eventStation = ""
    var lattitude = 0.0
    var longitude = 0.0
    init() {
        
    }
    init(nameStation: String,nameExitStation : String,eventStation: String,lattitude : Double, longitude : Double ) {
        self.init()
        self.nameStation = nameStation
        self.nameExitStation = nameExitStation
        self.eventStation = eventStation
        self.lattitude = lattitude
        self.longitude = longitude
    }
}
