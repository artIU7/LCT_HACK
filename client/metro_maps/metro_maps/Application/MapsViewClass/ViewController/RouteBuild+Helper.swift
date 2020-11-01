//
//  RouteBuild+Helper.swift
//  metro_maps
//
//  Created by Artem Stratienko on 01.11.2020.
//

import Foundation
import NMAKit

extension MapSceneController {
    
    func routeBuild() {
        let  myPosition = NMAGeoCoordinates(latitude: tempPositin.latitude,
                                            longitude: tempPositin.longitude)
        self.route.insert(NMAGeoCoordinates(latitude: myPosition.latitude,
                                            longitude: myPosition.longitude), at: 0)
        var routingMode = NMARoutingMode()
        let routeAlternative = NMARoutingMode.init(
            routingType: NMARoutingType.fastest,//shortest,//.fastest,
            transportMode: NMATransportMode.publicTransport,//pedestrian,
            routingOptions: []
        )
        routeAlternative.resultLimit = 0
        routingMode = NMARoutingMode.init(
            routingType: NMARoutingType.fastest,//shortest,//.fastest,
            transportMode: NMATransportMode.publicTransport,//pedestrian,
            routingOptions: []
        )
        if !(progress?.isFinished ?? false) {
            progress?.cancel()
        }
        print("computed route:\(route)")
        progress = coreRouter.calculateRoute(withStops: route, routingMode: routeAlternative, { (routeResult, error) in
                print("new route : \(self.route)")
                  
            if (error != NMARoutingError.none) {
                NSLog("Error in callback: \(error)")
                return
            }
            print(routeResult?.routes?.count)
            guard let route = routeResult?.routes?.first else {
                print("Empty Route result")
                return
            }
            //self.routeNav = route
            print(routeResult?.routes?.first)
            guard let box = route.boundingBox, let mapRoute = NMAMapRoute.init(route) else {
                print("Can't init Map Route")
                return
            }
            //mapRouteNav.init(route)
            if (self.mapRouts.count != 0) {
                for route in self.mapRouts {
                    self.mapView.remove(mapObject: route)
                }
                self.mapRouts.removeAll()
                self.route.removeAll()
            }
            print("count route segment : \(String(describing: mapRoute.route.geometry?.count))")
            let inbound = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            let outbound = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            let trackPoint = mapRoute.route.geometry
            let colorRHere = #colorLiteral(red: 0, green: 0.9267417652, blue: 0.6638478994, alpha: 0.3)
            let objectRoute = self.addSegment(route: trackPoint, color: colorRHere)
            let distanceRoute = self.distanceInRoute(trackPoint)
            self.mapRouts.append(mapRoute)
            self.mapView.set(boundingBox: box, animation: NMAMapAnimation.linear)
            self.showDialog(title: "Distance", message: "\(distanceRoute)")
            self.mapView.add(mapObject: mapRoute)
            print("computed mapRoute:\(String(describing: mapRoute.route.waypoints?.count))")
        })
    }
    open func distanceInRoute(_ routeIn : [NMAGeoCoordinates]?) -> Double {
           var allDistance = 0.0
           let segment = routeIn!.count
           for i in 0...segment - 2 {
               allDistance += distanceGeo(pointA: routeIn![i], pointB: routeIn![i + 1])
           }
           return allDistance
       }
    func addSegment(route : [NMAGeoCoordinates]?, color : UIColor) -> ([NMAMapPolyline],[NMAMapPolyline]) {
           var arrayLayer1 = [NMAMapPolyline]()
           var arrayLayer2 = [NMAMapPolyline]()
           let middleColor = color
           let newSize = route!.count
                      for j in 0...newSize - 1 {
                          var array = [NMAGeoCoordinates]()
                     
                       if j < newSize - 1 {
                           array.append(route![j])
                           array.append(route![j+1])
                       }
           }
             return (arrayLayer1,arrayLayer2)
       }
       private func showDialog(title: String, message: String) {
              let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
              alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              self.present(alertController, animated: true, completion: nil)
        }
    public func distanceGeo(pointA : NMAGeoCoordinates,pointB : NMAGeoCoordinates) -> Double {
        let toRad = Double.pi/180
        let radial = acos(sin(pointA.latitude*toRad)*sin(pointB.latitude*toRad) + cos(pointA.latitude*toRad)*cos(pointB.latitude*toRad)*cos((pointA.longitude - pointB.longitude)*toRad))
        let R = 6378.137//6371.11
        let D = (radial*R)*1000
        return D
    }
}
extension MapSceneController {
    func mapView(_ mapView: NMAMapView, didSelect objects: [NMAViewObject]) {
        print("select :: object \(objects)")
    }
}
