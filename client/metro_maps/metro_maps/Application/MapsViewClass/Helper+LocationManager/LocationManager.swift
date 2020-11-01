//
//  LocationManager.swift
//  metro_maps
//
//  Created by Artem Stratienko on 01.11.2020.
//

import Foundation
import NMAKit
import CoreLocation

extension MapSceneController  {
    // MARK 1
    func initLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    // MARK 2
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {
            print("Warning: No last location found")
            return
        }
        tempPositin = lastLocation.coordinate
        mapView.set(geoCenter: NMAGeoCoordinates(latitude: tempPositin.latitude, longitude: tempPositin.longitude), animation: .linear)
        
        addMarkerStation(NMAGeoCoordinates(latitude: tempPositin.latitude, longitude: tempPositin.longitude), index: 0, markerUI: indicator!)
        stopLocation()
    }
    // MARK 3
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    // MARK 4
    func startLocation() {
        locationManager.startUpdatingLocation()
    }
    // MARK 5
    func stopLocation() {
        locationManager.stopUpdatingLocation()
    }
}

