//
//  SceneARStation.swift
//  metro_maps
//
//  Created by Artem Stratienko on 01.11.2020.
//

import UIKit
import SceneKit
import ARKit
import CoreLocation

class SceneARController: UIViewController, ARSCNViewDelegate  {
    @IBOutlet weak var sceneView: ARSCNView!
    private let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        //sceneView.showsStatistics = true
        let scene = SCNScene()
        sceneView.scene = scene
        runSession()
        billboardnew(SCNVector3(x: 0, y: 1, z: 0), value: "2.3 km")
    }
    func runSession() {
           configuration.worldAlignment = .gravityAndHeading
           sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
       }
}
// методы session
extension SceneARController {
    
    // MARK: - ARSCNViewDelegate
    
    func session(_ session: ARSession, didFailWithError error: Error) {
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .normal:
            print("ready")
        case .notAvailable:
            print("wait")
        case .limited(let reason):
            print("limited tracking state: \(reason)")
        }
    }
    // rendering
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    }
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
    }
    }
extension SceneARController {
    // func computed offset for new coordinate
           func offsetComplete(_ pointStart : CLLocationCoordinate2D, _ pointEnd : CLLocationCoordinate2D) -> [Double] {
               let toRadian = Double.pi/180
               let toDegress = 180/Double.pi
               var deltaX = Double()
               var deltaZ = Double()
               var offset = [Double]()
               let defLat = (2*Double.pi * 6378.137)/360
               let defLot = (2*Double.pi*6378.137*cos(pointStart.latitude*toRadian))/360//*toDegress
                   if pointStart != nil {
                       if pointEnd != nil {
                           deltaX = (pointEnd.longitude - pointStart.longitude)*defLot*1000//*toDegress
                           deltaZ = (pointEnd.latitude - pointStart.latitude)*defLat*1000//*toDegress
                           var lon = (pointStart.longitude*defLot/*1000*/ + deltaX)/defLot/*1000*///*toDegress
                           var lat = (pointStart.latitude*defLat + deltaZ)/defLat//*toDegress
                           print("\(pointEnd.longitude - pointStart.longitude)")
                           print("\(pointEnd.latitude - pointStart.latitude)")
             }
        }
               offset.append(deltaX)
               offset.append(deltaZ)
           return offset
       }
}
