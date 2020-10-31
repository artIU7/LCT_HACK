//
//  ScrollViewControllerLayout.swift
//  metro_maps
//
//  Created by Artem Stratienko on 31.10.2020.
//

import UIKit
import Foundation
import Macaw

protocol SVGScrollViewDelegate {
    func getId(id : String?)
}

class ScrollViewControllerLayout: UIScrollView {
    
    let maxScale: CGFloat = 5.5
    let minScale: CGFloat = 0.25
    let maxWidth: CGFloat = 1000.0
    
    var svgView : SVGMacawView!
    var scrollViewDelegate : SVGScrollViewDelegate?
    
    private var scaleValue : CGFloat = 5.8
    private var zoomValue : CGFloat = 1.0
    
    public init(template: String, frame : CGRect) {
        super.init(frame: frame)
        svgView = SVGMacawView(template: template, frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width * scaleValue, height: self.frame.size.height * scaleValue))
        print(self.frame.size.width*scaleValue)
        addSubview(svgView)
        svgView.delegate = self
        contentSize = svgView.bounds.size
        zoomScale = zoomValue
        minimumZoomScale = minScale
        maximumZoomScale = maxScale
        decelerationRate = UIScrollView.DecelerationRate.normal
        delegate = self
        
        panGestureRecognizer.delegate = self
        pinchGestureRecognizer?.delegate = self

        panGestureRecognizer.isEnabled = true
        CGRect(x: -540, y: 0, width: 1080, height: 370); //wherever you want to scroll
        self.scrollRectToVisible(frame, animated: true)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

extension ScrollViewControllerLayout : SVGMacawViewDelegate {
    func getId(id: String?) {
        self.scrollViewDelegate?.getId(id: id)
    }
    
}

extension ScrollViewControllerLayout : UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return svgView
    }

    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.svgView.contentScaleFactor = scale //+ 5
        print("scale\(scale)")
        self.svgView.layoutIfNeeded()
    }
}

extension ScrollViewControllerLayout: UIGestureRecognizerDelegate {
    public override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let recognizer = gestureRecognizer as? UIPinchGestureRecognizer {
            let location = recognizer.location(in: self)
            let scale = Double(recognizer.scale)
            let anchor = Point(x: Double(location.x), y: Double(location.y))
            print(anchor.x)
            print(anchor.y)
            let node = self.svgView.node
            node.place = Transform.move(dx: anchor.x * (1.0 - scale), dy: anchor.y * (1.0 - scale)).scale(sx: scale, sy: scale)
        }

        return true
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


