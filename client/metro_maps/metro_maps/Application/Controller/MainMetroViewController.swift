//
//  MainMetroViewController.swift
//  metro_maps
//
//  Created by Artem Stratienko on 31.10.2020.
//

import UIKit
import RealmSwift

var statusSubView = false

var bufferSelected = ""
class MainMetroViewController: UIViewController {
    @IBOutlet weak var bottomView: MaterialView!
    var stationID  : Results<ModelStation>!
    @IBOutlet weak var fromField: UITextField!
    @IBOutlet weak var toField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomView.isHidden = !statusSubView
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(subView),
                                               name: NSNotification.Name("addSubView"),
                                               object: nil)
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        let realms = RealmService.shared.realm
        let stationInit = [
            ModelStation(
            id : "8fe15b9a-471a-11e5-93b1-e840e2132458",nameStation : "Щёлковская",lineID : "8fd77c4c-471a-11e5-9c19-aed022f77575"),
            ModelStation(
            id : "8fe7734a-471a-11e5-9691-a305092d2f10",nameStation : "Первомайская",lineID : "8fd77c4c-471a-11e5-9c19-aed022f77575"),
            ModelStation(
            id : "8fed8b7c-471a-11e5-a38f-9cc779261834",nameStation : "Измайловская",lineID : "8fd77c4c-471a-11e5-9c19-aed022f77575"),
            ModelStation(
            id : "8ff35ef8-471a-11e5-b58f-d9873b2d97a0",nameStation : "Партизанская",lineID : "8fd77c4c-471a-11e5-9c19-aed022f77575"),
            ModelStation(
            id : "8ff9552e-471a-11e5-aa10-d33191d3c698",nameStation : "Семёновская",lineID : "8fd77c4c-471a-11e5-9c19-aed022f77575"),
            ModelStation(
            id : "8fff2b84-471a-11e5-87fe-24f90d40a37c",nameStation : "Электрозаводская",lineID : "8fd77c4c-471a-11e5-9c19-aed022f77575"),
            ModelStation(
            id : "9005523e-471a-11e5-a6b5-066cb81ffc1a",nameStation : "Бауманская",lineID : "8fd77c4c-471a-11e5-9c19-aed022f77575"),
            ModelStation(
            id : "91164b88-471a-11e5-a539-9c44d7e6d60c",nameStation : "Курская",lineID : "90cc019a-471a-11e5-a77d-4d1a70b68fca"),
            ModelStation(
            id : "900b8078-471a-11e5-a4cb-96905f9ce89c",nameStation : "Курская(A)",lineID : "8fd77c4c-471a-11e5-9c19-aed022f77575"),
            ModelStation(
            id : "91e22b18-471a-11e5-8a1a-862c0e9ff412",nameStation : "Чкаловская",lineID : "91c9dd2e-471a-11e5-81d1-51d545884878"),
            ModelStation(
            id : "91e78cac-471a-11e5-9b34-ea1fe7e22ce3",nameStation : "Римская",lineID : "91c9dd2e-471a-11e5-81d1-51d545884878"),
            ModelStation(
            id : "8d7c4306-471a-11e5-ac4c-d3205eae3d5c",nameStation : "Площадь Ильича",lineID : "8d4a6c28-471a-11e5-ba91-961782854ada"),
            ModelStation(
            id : "8d75e060-471a-11e5-9c8f-ed332b49875f",nameStation : "Авиамоторная",lineID : "8d4a6c28-471a-11e5-ba91-961782854ada"),
            ModelStation(
            id : "8d6f270c-471a-11e5-bda5-c0cbff6061ac",nameStation : "Шоссе Энтузиастов",lineID : "8d4a6c28-471a-11e5-ba91-961782854ada"),
            ModelStation(
            id : "8d689310-471a-11e5-addd-7951056f7282",nameStation : "Перово",lineID : "8d4a6c28-471a-11e5-ba91-961782854ada"),
            ModelStation(
            id : "8d623c5e-471a-11e5-ab6e-fb7263b9cb1c",nameStation : "Новогиреево",lineID : "8d4a6c28-471a-11e5-ba91-961782854ada"),
            ModelStation(
            id : "8d58b80a-471a-11e5-9cc3-1a839c21e9f2",nameStation : "Новокосино",lineID : "8d4a6c28-471a-11e5-ba91-961782854ada"),
            ModelStation(
            id : "8d840dfc-471a-11e5-b4e2-0a84b4bb2568",nameStation : "Марксистская",lineID : "8d4a6c28-471a-11e5-ba91-961782854ada"),
            ModelStation(
            id : "911cd200-471a-11e5-8c31-23afc3f737bc",nameStation : "Таганская",lineID : "90cc019a-471a-11e5-a77d-4d1a70b68fca")
        ]
            
        
        let path = [
            ModelPath(id:"station-path-8fe7734a-471a-11e5-9691-a305092d2f10_8fe15b9a-471a-11e5-93b1-e840e2132458", staionIDStart: "8fe15b9a-471a-11e5-93b1-e840e2132458", staionIDEnd: "8fe7734a-471a-11e5-9691-a305092d2f10"),
            ModelPath(id:"station-path-8fed8b7c-471a-11e5-a38f-9cc779261834_8fe7734a-471a-11e5-9691-a305092d2f10", staionIDStart: "8fe7734a-471a-11e5-9691-a305092d2f10", staionIDEnd: "8fe7734a-471a-11e5-9691-a305092d2f10"),
            ModelPath(id:"station-path-8ff35ef8-471a-11e5-b58f-d9873b2d97a0_8fed8b7c-471a-11e5-a38f-9cc779261834", staionIDStart: "8fed8b7c-471a-11e5-a38f-9cc779261834", staionIDEnd: "8ff35ef8-471a-11e5-b58f-d9873b2d97a0"),
            ModelPath(id:"station-path-8ff9552e-471a-11e5-aa10-d33191d3c698_8ff35ef8-471a-11e5-b58f-d9873b2d97a0", staionIDStart: "8ff35ef8-471a-11e5-b58f-d9873b2d97a0", staionIDEnd: "8ff9552e-471a-11e5-aa10-d33191d3c698"),
            ModelPath(id:"station-path-8fff2b84-471a-11e5-87fe-24f90d40a37c_8ff9552e-471a-11e5-aa10-d33191d3c698", staionIDStart: "8ff9552e-471a-11e5-aa10-d33191d3c698", staionIDEnd: "8fff2b84-471a-11e5-87fe-24f90d40a37c"),
            ModelPath(id:"station-path-9005523e-471a-11e5-a6b5-066cb81ffc1a_8fff2b84-471a-11e5-87fe-24f90d40a37c", staionIDStart: "8fff2b84-471a-11e5-87fe-24f90d40a37c", staionIDEnd: "9005523e-471a-11e5-a6b5-066cb81ffc1a"),
            ModelPath(id:"station-path-900b8078-471a-11e5-a4cb-96905f9ce89c_9005523e-471a-11e5-a6b5-066cb81ffc1a", staionIDStart: "9005523e-471a-11e5-a6b5-066cb81ffc1a", staionIDEnd: "900b8078-471a-11e5-a4cb-96905f9ce89c"),
            ModelPath(id:"station-transition-900b8078-471a-11e5-a4cb-96905f9ce89c_91164b88-471a-11e5-a539-9c44d7e6d60c", staionIDStart: "91164b88-471a-11e5-a539-9c44d7e6d60c", staionIDEnd: "900b8078-471a-11e5-a4cb-96905f9ce89c"),
            ModelPath(id:"station-transition-91e22b18-471a-11e5-8a1a-862c0e9ff412_91164b88-471a-11e5-a539-9c44d7e6d60c", staionIDStart: "91164b88-471a-11e5-a539-9c44d7e6d60c", staionIDEnd: "91e22b18-471a-11e5-8a1a-862c0e9ff412"),
            ModelPath(id:"station-path-91e22b18-471a-11e5-8a1a-862c0e9ff412_91e78cac-471a-11e5-9b34-ea1fe7e22ce3", staionIDStart: "91e22b18-471a-11e5-8a1a-862c0e9ff412", staionIDEnd: "91e78cac-471a-11e5-9b34-ea1fe7e22ce3"),
            ModelPath(id:"station-transition-91e78cac-471a-11e5-9b34-ea1fe7e22ce3_8d7c4306-471a-11e5-ac4c-d3205eae3d5c", staionIDStart: "91e78cac-471a-11e5-9b34-ea1fe7e22ce3", staionIDEnd: "8d7c4306-471a-11e5-ac4c-d3205eae3d5c"),
            ModelPath(id:"station-path-8d7c4306-471a-11e5-ac4c-d3205eae3d5c_8d75e060-471a-11e5-9c8f-ed332b49875f", staionIDStart: "8d7c4306-471a-11e5-ac4c-d3205eae3d5c", staionIDEnd: "8d75e060-471a-11e5-9c8f-ed332b49875f"),
            ModelPath(id:"station-path-8d75e060-471a-11e5-9c8f-ed332b49875f_8d6f270c-471a-11e5-bda5-c0cbff6061ac", staionIDStart: "8d75e060-471a-11e5-9c8f-ed332b49875f", staionIDEnd: "8d6f270c-471a-11e5-bda5-c0cbff6061ac"),
            ModelPath(id:"station-path-8d6f270c-471a-11e5-bda5-c0cbff6061ac_8d689310-471a-11e5-addd-7951056f7282", staionIDStart: "8d6f270c-471a-11e5-bda5-c0cbff6061ac", staionIDEnd: "8d689310-471a-11e5-addd-7951056f7282"),
            ModelPath(id:"station-path-8d689310-471a-11e5-addd-7951056f7282_8d623c5e-471a-11e5-ab6e-fb7263b9cb1c", staionIDStart: "8d689310-471a-11e5-addd-7951056f7282", staionIDEnd: "8d623c5e-471a-11e5-ab6e-fb7263b9cb1c"),
            ModelPath(id:"station-path-8d623c5e-471a-11e5-ab6e-fb7263b9cb1c_8d58b80a-471a-11e5-9cc3-1a839c21e9f2", staionIDStart: "8d623c5e-471a-11e5-ab6e-fb7263b9cb1c", staionIDEnd: "8d58b80a-471a-11e5-9cc3-1a839c21e9f2"),
            ModelPath(id:"station-transition-8d840dfc-471a-11e5-b4e2-0a84b4bb2568_911cd200-471a-11e5-8c31-23afc3f737bc", staionIDStart: "911cd200-471a-11e5-8c31-23afc3f737bc", staionIDEnd: "8d840dfc-471a-11e5-b4e2-0a84b4bb2568"),
            ModelPath(id:"station-path-91164b88-471a-11e5-a539-9c44d7e6d60c_911cd200-471a-11e5-8c31-23afc3f737bc", staionIDStart: "911cd200-471a-11e5-8c31-23afc3f737bc", staionIDEnd: "91164b88-471a-11e5-a539-9c44d7e6d60c")]

        var pathRoute = try! Realm().objects(ModelPath.self)
        if pathRoute.isEmpty {
        path.map({
            RealmService.shared.createStation($0)
        })
        }
        var station = try! Realm().objects(ModelStation.self)
        if station.isEmpty {
        stationInit.map({
            RealmService.shared.createStation($0)
        })
        }
        // Do any additional setup after loading the view.
    }

    // slect position
    @objc func subView() {
        bottomView.isHidden = false//!statusSubView
    }
    @IBAction func fromStation(_ sender: Any) {
        fromField.text = bufferSelected
        NotificationCenter.default.post(name: NSNotification.Name("selectPoint"), object: nil)
    }
    
    @IBAction func toStation(_ sender: Any) {
        toField.text = bufferSelected
        NotificationCenter.default.post(name: NSNotification.Name("routeBuild"), object: nil)
        
        bottomView.isHidden = true
        statusIndex = true
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFromContainerToLayout" {
            let destination = (segue.destination as! SVGLayoutController)
            destination.delegate = self
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
extension MainMetroViewController : SVGLayoutViewControllerDelegate {
    func getNodeID(id: String?) {
        if let name = HelperNodeName.getNodeID(id: "") {
            // to View
        }
    }
}
