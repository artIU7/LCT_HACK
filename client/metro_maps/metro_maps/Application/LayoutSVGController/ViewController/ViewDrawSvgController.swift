//
//  ViewDrawSvgController.swift
//  metro_maps
//
//  Created by Artem Stratienko on 31.10.2020.
//

import UIKit
import Macaw
import SWXMLHash


var stationID = [String]()
var nodeStation = [MyNode]()
var linkPath = [String]()
let backGroundColor : UIColor = UIColor.white
protocol SVGMacawViewDelegate {
    func getId(id : String?)
}
var stationCaption = [String]()
var stationNode = [String]()
class SVGMacawView: MacawView {

    var delegate : SVGMacawViewDelegate?
    
    private var pathArray = [String]()
    
    init(template: String, frame : CGRect) {
        super.init(frame : frame)
        self.backgroundColor = backGroundColor//.black
        var stn = [
            "8d623c5e-471a-11e5-ab6e-fb7263b9cb1c", // Новокосино - Новогиреево
            "8d58b80a-471a-11e5-9cc3-1a839c21e9f2" //
        ]
        var pathRoute = [String]()
        let link = true
        if link {
            pathRoute.append(stn.first! + "_" + stn.last!)
            pathRoute.append(stn.last! + "_" + stn.first!)
        }
         stationCaption = stn.map({"station-caption-" + $0})
         stationNode = stn.map({"station-" + $0})
        
        if let node = try? SVGParser.parse(resource: template, ofType: "svg", inDirectory: nil, fromBundle: Bundle.main) {
            if let group = node as? Group {
                let rect = Rect.init(x: 1, y: 1, w: 4000, h: 4000)
                let backgroundShape = Shape(form: rect, fill: Color.white, tag: ["back"])
                var contents = group.contents
                contents.insert(backgroundShape, at: 0)
                group.contents = contents
                self.node = group
                if let url = Bundle.main.url(forResource: template, withExtension: "svg") {
                    if let xmlString = try? String(contentsOf: url) {
                        let xml = SWXMLHash.parse(xmlString)
                        enumerate(indexer: xml, level: 0)
                        pathRoute = pathRoute.map({"station-path-"+$0})
                        print("route :\(pathRoute)")
                       // pathArray = pathArray.filter ({
                       //     $0 == pathRoute.first ||
                        //    $0 == pathRoute.last ||
                         //   $0 == stationCaption.first || $0 == stationNode.last
                         //   })
                        var firstArray = [String]()
                        var secondArray = [String]()
                        var thirdyArray = [String]()
                        
                        for sCap in stationCaption {
                            if secondArray.isEmpty {
                                secondArray = pathArray.filter({
                                    $0 == sCap
                                })
                            } else {
                                secondArray += pathArray.filter({
                                    $0 == sCap
                                })
                            }
                        }
                        for path in pathRoute {
                            if thirdyArray.isEmpty {
                                thirdyArray = pathArray.filter({
                                    $0 == path
                                })
                            } else {
                                thirdyArray += pathArray.filter({
                                    $0 == path
                                })
                            }
                        }
                        for stn in stationNode {
                            if firstArray.isEmpty {
                                firstArray = pathArray.filter({
                                    $0 == stn
                                })
                            } else {
                                firstArray += pathArray.filter({
                                    $0 == stn
                                })
                            }
                         
                        }
                        pathArray = firstArray+secondArray+thirdyArray
                    
                        print(pathArray)
                        for case let element in pathArray {
                            self.registerForSelection(nodeTag: element)
                        }
                    }
                }
            } else {
                self.node = node
            }

            // layout
            self.contentMode = .scaleAspectFit
        }
    }
    
    private func enumerate(indexer: XMLIndexer, level: Int) {
        for child in indexer.children {
            if let element = child.element {
                if let idAttribute = element.attribute(by: "id") {
                    let text = idAttribute.text
                    pathArray.append(text)
                }
            }
            enumerate(indexer: child, level: level + 1)
        }
    }
    
    private func registerForSelection(nodeTag : String) {
        self.node.nodeBy(tag: nodeTag)?.onTouchPressed({ (touch) in
            self.addStationID()
            self.addLinkPath()
            
            let nodeShape = self.node.nodeBy(tag: nodeTag) // as! Shape//Shape
           // let nodeSelect = nodeShape.contents.first as! Shape//.fill = Color.aliceBlue
           // nodeShape.fill = Color.blue
            let typeNode = type(of: nodeShape!)
            if typeNode == Shape.self {
                let nodeSelectGroup = nodeShape as! Shape
                nodeSelectGroup.opacity = 0.7
                nodeSelectGroup.fill = Color.gray
                let nodeTextStart = self.node.nodeBy(tag: stationCaption.last!)
                let nodeTextEnd = self.node.nodeBy(tag: stationCaption.first!)

                self.findPath()
            } else if typeNode == Text.self {
                let labelStation = nodeShape as! Text
                labelStation.fill = Color.green
            }
            //nodeSelect.fill = Color.blue
            self.delegate?.getId(id: nodeTag)
        })
        // longPresstouch(::)
        
    }
    func addStationID() {
        stationID = ["8d58b80a-471a-11e5-9cc3-1a839c21e9f2",// Новокосино
                     "8d623c5e-471a-11e5-ab6e-fb7263b9cb1c",// Новогиреево
                     "8d689310-471a-11e5-addd-7951056f7282",// Перово
                     "8d6f270c-471a-11e5-bda5-c0cbff6061ac", // Шоссе Энтузиастов
                     "8d75e060-471a-11e5-9c8f-ed332b49875f", // Авиамоторная
                     "8d7c4306-471a-11e5-ac4c-d3205eae3d5c", // Площадь Ильича
                     "91e78cac-471a-11e5-9b34-ea1fe7e22ce3", // Римская
                     "91e22b18-471a-11e5-8a1a-862c0e9ff412", // Чкаловская
                     "91164b88-471a-11e5-a539-9c44d7e6d60c", // Курская
                     "8d840dfc-471a-11e5-b4e2-0a84b4bb2568", // Марксистская
                     "911cd200-471a-11e5-8c31-23afc3f737bc", // Таганская
                    ]
        print(stationID)
    }
    func addLinkPath() {
        linkPath = [
            "8d623c5e-471a-11e5-ab6e-fb7263b9cb1c_8d58b80a-471a-11e5-9cc3-1a839c21e9f2", // Новокосино - Новогиреево
            "8d623c5e-471a-11e5-ab6e-fb7263b9cb1c_8d689310-471a-11e5-addd-7951056f7282", // Новогиреево - Перово
            "8d689310-471a-11e5-addd-7951056f7282_8d6f270c-471a-11e5-bda5-c0cbff6061ac", // Перово - Шоссе Энтузиастов
            "8d6f270c-471a-11e5-bda5-c0cbff6061ac_8d75e060-471a-11e5-9c8f-ed332b49875f", // Шоссе Энтузиастов - Авиамоторная
            "8d75e060-471a-11e5-9c8f-ed332b49875f_8d7c4306-471a-11e5-ac4c-d3205eae3d5c", // Авиамоторная - Площадь Ильича
            "8d7c4306-471a-11e5-ac4c-d3205eae3d5c_91e78cac-471a-11e5-9b34-ea1fe7e22ce3", // Площадь Ильича - Римская
            "91e78cac-471a-11e5-9b34-ea1fe7e22ce3_91e22b18-471a-11e5-8a1a-862c0e9ff412", // Римская - Чкаловская
            "91e22b18-471a-11e5-8a1a-862c0e9ff412_91164b88-471a-11e5-a539-9c44d7e6d60c", // Чкаловская - Курская
            
            "8d840dfc-471a-11e5-b4e2-0a84b4bb2568_8d7c4306-471a-11e5-ac4c-d3205eae3d5c", // Площадь Ильича - Марксисткая
            "8d840dfc-471a-11e5-b4e2-0a84b4bb2568_911cd200-471a-11e5-8c31-23afc3f737bc", // Марксисткая- Таганская
            "91164b88-471a-11e5-a539-9c44d7e6d60c_911cd200-471a-11e5-8c31-23afc3f737bc", // Таганская- Курская
        ]
    }
    func findPath() {
        stationID.map({
            nodeStation.append(MyNode(name: $0))
        })
        print(nodeStation)
        // init matrix graph
        for i in 0...nodeStation.count - 1 {
            for j in 0...nodeStation.count - 1 {
                for path in linkPath {
                    if path == nodeStation[i].name + "_" + nodeStation[j].name {
                        print("connection - true")
                        nodeStation[i].connections.append(Connection(to: nodeStation[j], weight: 3 + i + j))
                        nodeStation[j].connections.append(Connection(to: nodeStation[i], weight: 3 + i + j))
                    }
                }
            }
        }
        /*
        let nodeA = MyNode(name: "A")
        let nodeB = MyNode(name: "B")
        let nodeC = MyNode(name: "C")
        let nodeD = MyNode(name: "D")
        let nodeE = MyNode(name: "E")

        nodeA.connections.append(Connection(to: nodeB, weight: 1))
        nodeB.connections.append(Connection(to: nodeC, weight: 3))
        nodeC.connections.append(Connection(to: nodeD, weight: 1))
        nodeB.connections.append(Connection(to: nodeE, weight: 1))
        nodeE.connections.append(Connection(to: nodeC, weight: 1))*/

        let sourceNode = nodeStation[0]
        let destinationNode = nodeStation[10]

        var path = shortestPath(source: sourceNode, destination: destinationNode)

        if let succession: [String] = path?.array.reversed().flatMap({ $0 as? MyNode}).map({$0.name}) {
          print("Путь : \(succession)")
        } else {
          print("Нет связи\(sourceNode.name) & \(destinationNode.name)")
        }
    }
    
    
    @objc required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
