//
//  ViewDrawSvgController.swift
//  metro_maps
//
//  Created by Artem Stratienko on 31.10.2020.
//

import UIKit
import Macaw
import SWXMLHash
import RealmSwift
//
var startPoint = String()
var endPoint = String()
var statusIndex = false
var firstIndex = Int()
var lastIndex = Int()
var routeWP = [String]()
var stationID = [String]()
var nodeStation = [MyNode]()
var linkPath = [String]()
let backGroundColor : UIColor = UIColor.white
protocol SVGMacawViewDelegate {
    func getId(id : String?)
}
var stationCaption = [String]()
var stationNode = [String]()
var pathArrayDeykstra = [String]()
class SVGMacawView: MacawView {

    var delegate : SVGMacawViewDelegate?
    private var allArray = [String]()
    private var pathArray = [String]()
    
    init(template: String, frame : CGRect) {
        super.init(frame : frame)
        self.backgroundColor = backGroundColor//.black
        if let node = try? SVGParser.parse(resource: template, ofType: "svg", inDirectory: nil, fromBundle: Bundle.main) {
            if let group = node as? Group {
                let rect = Rect.init(x: 1, y: 1, w: 4000, h: 4000)
                let backgroundShape = Shape(form: rect, fill: Color.white, tag: ["back"])
                var contents = group.contents
                contents.insert(backgroundShape, at: 0)
                group.contents = contents
                self.node = group
                //self.node.opacity = 0.5
                
                if let url = Bundle.main.url(forResource: template, withExtension: "svg") {
                    if let xmlString = try? String(contentsOf: url) {
                        let xml = SWXMLHash.parse(xmlString)
                        enumerate(indexer: xml, level: 0)
                     
                        pathArray = [
                            "station-8fe15b9a-471a-11e5-93b1-e840e2132458",
                            "station-8fe7734a-471a-11e5-9691-a305092d2f10",
                            "station-8fed8b7c-471a-11e5-a38f-9cc779261834",
                            "station-8ff35ef8-471a-11e5-b58f-d9873b2d97a0",
                            "station-8ff9552e-471a-11e5-aa10-d33191d3c698",
                            "station-8fff2b84-471a-11e5-87fe-24f90d40a37c",
                            "station-9005523e-471a-11e5-a6b5-066cb81ffc1a",
                            "station-91164b88-471a-11e5-a539-9c44d7e6d60c",
                            "station-900b8078-471a-11e5-a4cb-96905f9ce89c",
                            "station-91e22b18-471a-11e5-8a1a-862c0e9ff412",
                            "station-91e78cac-471a-11e5-9b34-ea1fe7e22ce3",
                            "station-91e78cac-471a-11e5-9b34-ea1fe7e22ce3",
                            "station-8d7c4306-471a-11e5-ac4c-d3205eae3d5c",
                            "station-8d75e060-471a-11e5-9c8f-ed332b49875f",
                            "station-8d6f270c-471a-11e5-bda5-c0cbff6061ac",
                            "station-8d689310-471a-11e5-addd-7951056f7282",
                            "station- 8d623c5e-471a-11e5-ab6e-fb7263b9cb1c",
                            "station-8d58b80a-471a-11e5-9cc3-1a839c21e9f2",
                            "station-8d840dfc-471a-11e5-b4e2-0a84b4bb2568",
                            "station-911cd200-471a-11e5-8c31-23afc3f737bc"
                        ]
                        for case let element in pathArray {
                            self.registerForSelection(nodeTag: element)
                        }
                    }
                }
            } else {
               // node.opacity = 0.7
                self.node = node
            }

            // layout
            self.contentMode = .scaleAspectFit
        }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(drawRoute),
                                               name: NSNotification.Name("routeBuild"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(selectPoint),
                                               name: NSNotification.Name("selectPoint"),
                                               object: nil)
        self.initGraph()
    }
    @objc func selectPoint() {
        statusIndex = true
    }
    @objc func drawRoute() {
        nodeStation.removeAll()
        self.initGraph()
        self.hideAll()
        let stationShow = self.findPath(startPoint: firstIndex, endPoint: lastIndex)
        for statiom in stationShow {
            let stationPath = self.node.nodeBy(tag: "station-"+statiom)
            let typeNode = type(of: stationPath!)
            if typeNode == Shape.self {
                let nodeStation = stationPath as! Shape
                nodeStation.opacity = 1.0
                nodeStation.stroke = Stroke(fill: Color.white, width: 2)
            } else {
                let grad = stationPath as! Group
                let nodeStation = grad.contents.first as! Shape//.fill = Color.aliceBlue
                nodeStation.opacity = 1.0
                nodeStation.stroke = Stroke(fill: Color.white, width: 2)
            }
            let stationPathCaption = self.node.nodeBy(tag: "station-caption-"+statiom)
            let typeNodeT = type(of: stationPathCaption!)
            if typeNodeT == Text.self {
                let nodeStationT = stationPathCaption as! Text
                nodeStationT.opacity = 1.0
                nodeStationT.fill = Color.darkCyan
            }
            
        }
        var pathRoute = try! Realm().objects(ModelPath.self)
        print(pathRoute)
        for elemnet in pathRoute {
            for i  in 0...stationShow.count - 2 {
                if (elemnet.staionIDStart == stationShow[i] ||
                   elemnet.staionIDStart == stationShow[i+1]) &&
                   (elemnet.staionIDStart == stationShow[i + 1] ||
                   elemnet.staionIDStart == stationShow[i])
                    {
                    let stationPath = self.node.nodeBy(tag: elemnet.id)
                    let typeNode = type(of: stationPath!)
                    if typeNode == Shape.self {
                        let nodeStation = stationPath as! Shape
                        nodeStation.opacity = 1.0
                        nodeStation.stroke = Stroke(fill: Color.white, width: 2)
                    } else {
                        let grad = stationPath as! Group
                        let nodeStation = grad.contents.first as! Shape//.fill = Color.aliceBlue
                        nodeStation.opacity = 1.0
                        nodeStation.stroke = Stroke(fill: Color.white, width: 2)
                    }
                }
            }
        }
    }
    func hideAll() {
        allArray.map({
            self.node.nodeBy(tag: $0)?.opacity = 0.1
        })
        //self.node.opacity = 0.3
        
    }
    func fromRealmObject() {
        var stations = try! Realm().objects(ModelStation.self)
        print(stations)
    }
    func fromRealmObjectPath() {
        var pathRoute = try! Realm().objects(ModelPath.self)
        print(pathRoute)
    }
    private func enumerate(indexer: XMLIndexer, level: Int) {
        for child in indexer.children {
            if let element = child.element {
                if let idAttribute = element.attribute(by: "id") {
                    let text = idAttribute.text
                    pathArray.append(text)
                    allArray.append(text)
                }
            }
            enumerate(indexer: child, level: level + 1)
        }
    }
    
    private func registerForSelection(nodeTag : String) {
        self.node.nodeBy(tag: nodeTag)?.onTouchPressed({ [self] (touch) in
            let nameStationRealm = try! Realm().objects(ModelStationName.self)
            let nodeShape = self.node.nodeBy(tag: nodeTag) // as! Shape//Shape
            let typeNode = type(of: nodeShape!)
            if typeNode == Shape.self {
                let nodeSelectGroup = nodeShape as! Shape
                nodeSelectGroup.opacity = 0.7
                let point = nameStationRealm.filter({ "station-" + $0.id == nodeTag})
                for i in 0...nodeStation.count - 1 {
                    if "station-" + nodeStation[i].name == nodeTag {
                        if statusIndex == false {
                            firstIndex = i
                            startPoint = point.first!.nameStation
                        } else {
                            lastIndex = i
                            endPoint = point.first!.nameStation
                        }
                    }
                }
                NotificationCenter.default.post(name: NSNotification.Name("addSubView"), object: nil)
                /*let nodeTextStart = self.node.nodeBy(tag: "station-caption-"+nodeTag)
                let nodeTextStartT = nodeTextStart as! Text
                nodeTextStartT.fill = Color.darkGray*/
            }
            self.delegate?.getId(id: nodeTag)
        })
        // longPresstouch(::)
        
    }
 
    func initGraph() {
        let stationRealm = try! Realm().objects(ModelStation.self)
        var pathRealm = try! Realm().objects(ModelPath.self)
        print("init ::: \(stationRealm)")
        print("init ::: \(pathRealm)")
        for station in stationRealm {
            nodeStation.append(MyNode(name: station.id))
        }
        for i in 0...nodeStation.count - 1 {
            for j in 0...nodeStation.count - 1 {
                for path in pathRealm {
                    if path.id == "station-path-" + nodeStation[i].name + "_" + nodeStation[j].name ||
                    path.id == "station-transition-" + nodeStation[i].name + "_" + nodeStation[j].name
                        {
                        print("connection - true")
                        nodeStation[i].connections.append(Connection(to: nodeStation[j], weight: 3 + i + j))
                        nodeStation[j].connections.append(Connection(to: nodeStation[i], weight: 3 + i + j))
                    }
                }
            }
        }
    }
    
    func findPath(startPoint : Int,endPoint : Int) -> [String] {
        let sourceNode = nodeStation[startPoint]
        let destinationNode = nodeStation[endPoint]

        var path = shortestPath(source: sourceNode, destination: destinationNode)

        if let succession: [String] = path?.array.reversed().flatMap({ $0 as? MyNode}).map({$0.name}) {
          print("Путь : \(succession)")
            return succession
        } else {
          print("Нет связи\(sourceNode.name) & \(destinationNode.name)")
        }
        return []
    }
    @objc required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
