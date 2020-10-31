//
//  MainMetroViewController.swift
//  metro_maps
//
//  Created by Artem Stratienko on 31.10.2020.
//

import UIKit

class MainMetroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
