//
//  MapSceneController.swift
//  metro_maps
//
//  Created by Artem Stratienko on 01.11.2020.
//

import UIKit
import NMAKit

var tempPositin : CLLocationCoordinate2D!

class MapSceneController: UIViewController {

    @IBOutlet var mapView: NMAMapView!
    
    let locationManager = CLLocationManager()
    
    var mapRouts = [NMAMapRoute]()
    var progress: Progress? = nil
    var coreRouter: NMACoreRouter!
    var route = [NMAGeoCoordinates]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coreRouter = NMACoreRouter()

        self.mapView.mapScheme = NMAMapSchemeNormalNightTransit
        
        self.initLocationManager()
        self.startLocation()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
         super.viewDidDisappear(animated)
         progress?.cancel()
     }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MapSceneController : NMAMapGestureDelegate,NMAMapViewDelegate {}
extension MapSceneController : CLLocationManagerDelegate {}
