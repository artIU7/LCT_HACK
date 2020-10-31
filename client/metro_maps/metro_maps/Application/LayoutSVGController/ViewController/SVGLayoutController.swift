//
//  SVGLayoutController.swift
//  metro_maps
//
//  Created by Artem Stratienko on 31.10.2020.
//

import UIKit

protocol SVGLayoutViewControllerDelegate {
    func getNodeID(id : String?)
}

class SVGLayoutController: UIViewController {
    var svgScrollView: ScrollViewControllerLayout!
        
    var delegate : SVGLayoutViewControllerDelegate?
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.svgScrollView = ScrollViewControllerLayout(template: "mt_hack_2020", frame: self.view.frame)
        svgScrollView.scrollViewDelegate = self
        self.view.addSubview(self.svgScrollView)
        self.svgScrollView.backgroundColor = .clear
        self.svgScrollView.scrollViewDelegate = self
        }

    }

    extension SVGLayoutController : SVGScrollViewDelegate {
        func getId(id : String?) {
            self.delegate?.getNodeID(id: id)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
