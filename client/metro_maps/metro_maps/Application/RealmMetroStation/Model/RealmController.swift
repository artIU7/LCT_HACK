//
//  RealmControlle.swift
//  metro_maps
//
//  Created by Artem Stratienko on 31.10.2020.
//

import Foundation
import RealmSwift


class RealmService {
    
    private init() {}
    static let shared = RealmService()
    let realm = try! Realm()
    
    func createStation<T : Object>(_ object : T) {
        try! realm.write {
            realm.add(object)
        }
    }
}
