//
//  helper+addStationBilbboard.swift
//  metro_maps
//
//  Created by Artem Stratienko on 01.11.2020.
//

import Foundation
import ARKit

extension SceneARController {

func billboardnew(_ position : SCNVector3, value : String) {
          let material = SCNMaterial()
          let textGeometry = SCNText(string: "Маршрут до остановки " + " " + value, extrusionDepth: 0.5)
          textGeometry.font = UIFont(name: "Arial", size: 2)
          textGeometry.firstMaterial!.diffuse.contents = UIColor.white
          let textNode = SCNNode(geometry: textGeometry)
          let (min, max) = textGeometry.boundingBox
          let dx = min.x + 0.5 * (max.x - min.x)
          let dy = min.y + 0.5 * (max.y - min.y)
          let dz = min.z + 0.5 * (max.z - min.z)
          textNode.pivot = SCNMatrix4MakeTranslation(dx, dy, dz)

          textNode.scale = SCNVector3(0.01, 0.01, 0.01)
          let billboardScene = SCNScene(named: "ar.scnassets/board.scn")! //
          let billboardNode = billboardScene.rootNode.childNode(withName: "board",
                                                                   recursively: false)!
          let plane = billboardNode//SCNPlane(width: 0.2, height: 0.2)
          let blueMaterial = SCNMaterial()
          blueMaterial.diffuse.contents = UIColor.blue
          let parentNode = plane//SCNNode(geometry: plane) //
          let yFreeConstraint = SCNBillboardConstraint()
          yFreeConstraint.freeAxes = [.Y] // optionally
          parentNode.constraints = [yFreeConstraint] //

          parentNode.position = position//SCNVector3(0, 0, -0.5)
          parentNode.addChildNode(textNode)
          parentNode.scale = SCNVector3(3, 3, 3)
          //addChildNode(parentNode)
          sceneView.scene.rootNode.addChildNode(parentNode) //
      }
}
