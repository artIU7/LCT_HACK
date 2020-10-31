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
        
        let button = UIButton(frame: CGRect(x: 100,
                                                    y: 100,
                                                    width: 200,
                                                    height: 60))
                button.setTitle("Test",
                                for: .normal)
                button.setTitleColor(.systemBlue,
                                     for: .normal)
                
                button.addTarget(self,
                                 action: #selector(buttonAction),
                                 for: .touchUpInside)
                
                self.view.addSubview(button)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(subView),
                                               name: NSNotification.Name("addSubView"),
                                               object: nil)
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        let realms = RealmService.shared.realm
        let pop = ModelStation(id : "1",
                               nameStation : "2",
                               lineID : "3")
        RealmService.shared.createStation(pop)
        // Do any additional setup after loading the view.
    }

    // slect position
    @objc func subView() {
        bottomView.isHidden = false//!statusSubView
    }

    @objc func buttonAction() {
          print("Button pressed")
      }
    @IBAction func fromStation(_ sender: Any) {
        fromField.text = bufferSelected
    }
    
    @IBAction func toStation(_ sender: Any) {
        toField.text = bufferSelected
        NotificationCenter.default.post(name: NSNotification.Name("routeBuild"), object: nil)
        bottomView.isHidden = true
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
