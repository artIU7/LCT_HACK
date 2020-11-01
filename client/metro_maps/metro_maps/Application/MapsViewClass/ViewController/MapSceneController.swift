//
//  MapSceneController.swift
//  metro_maps
//
//  Created by Artem Stratienko on 01.11.2020.
//

import UIKit
import NMAKit
import RealmSwift

var tempPositin : CLLocationCoordinate2D!

class MapSceneController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    private var data = [""]
    @IBOutlet weak var tableView: UITableView!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
          case self.tableView:
             return self.data.count
           default:
             return 0
          }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "RealmViewCell", for: indexPath) as! RealmViewCell
           cell.textLabel?.text = self.data[indexPath.row]
           return cell
    }
    

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
        
        self.tableView.register(RealmViewCell.self, forCellReuseIdentifier: "RealmViewCell")

        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        let eventStation = try! Realm().objects(ModelStationExit.self)
        let stationInfo = eventStation.filter({
                        $0.nameStation == startPoint}
        )
        var newElement = eventStation
        for element in eventStation {
            if element.nameStation == startPoint {
                addMarkerStation(NMAGeoCoordinates(latitude: element.lattitude, longitude: element.longitude), index: 1, markerUI: station!)
                mapView.set(geoCenter: NMAGeoCoordinates(latitude: element.lattitude, longitude: element.longitude), animation: .linear)
                data.append(element.nameExitStation)
                tableView.reloadData()
            }
        }
        self.mapView.gestureDelegate = self
        self.mapView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
         super.viewDidDisappear(animated)
         progress?.cancel()
     }
    func addMarkerStation(_ positionAnchor : NMAGeoCoordinates, index : Int, markerUI : UIImage) {
        let marker = NMAMapMarker(geoCoordinates: positionAnchor, image: markerUI)
          marker.resetIconSize()
          marker.setSize(CGSize(width: 1, height: 1), forZoomRange: NSRange(location: 5,length: 20))
          //markerAR["AR \(index)"] = marker
          //infoMarker[marker.hashValue] = index
          self.mapView.add(mapObject: marker)
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
