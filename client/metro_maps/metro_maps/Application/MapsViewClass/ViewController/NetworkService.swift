//
//  NetworkService.swift
//  metro_maps
//
//  Created by Artem Stratienko on 01.11.2020.
//

import Foundation
import RealmSwift

var stations = [StationExit]()

func fetch_mosdata_api() {
    let urlString = "https://apidata.mos.ru/v1/datasets/624/features?api_key=5e31d338226d8ac7a2efcf08320f3fea"
        guard let url = URL(string: urlString) else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data,response,error) in
            if let response = response {
             //   print(response)
            }
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let preload = json as! [String:Any]
                print("json response decoder")
                let feature = preload["features"] as! NSArray
          //      print(feature)
                for element in feature {
         //           print(element)
                  let respone = element as! [String:Any]
                  let properties = respone["properties"] as! [String:Any]
                  let attribute = properties["Attributes"] as! [String:Any]
                  
                    let nameStation = attribute["NameOfStation"] as! String
                    let eventStation = attribute["ModeOnEvenDays"] as! String
                    let nameExitStation = attribute["Name"] as! String
                    let lattitudeExit = attribute["Latitude_WGS84"] as! Double
                    let longitudeExit = attribute["Longitude_WGS84"] as! Double
                    let station = StationExit(nameStation: nameStation,
                                              nameExitStation: nameExitStation,
                                              eventStation: eventStation,
                                              lattitude: lattitudeExit,
                                              longitude: longitudeExit)
                    stations.append(station)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
