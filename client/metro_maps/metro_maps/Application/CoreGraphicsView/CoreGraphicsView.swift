//
//  CoreGraphicsView.swift
//  metro_maps
//
//  Created by Artem Stratienko on 01.11.2020.
//

import UIKit

@IBDesignable

class CoreGraphicsDraw: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let pathRect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        let color = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 0.35)
        let target = #colorLiteral(red: 0.9509194829, green: 0.9473318443, blue: 1, alpha: 0.25)
        let route = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 0.3)
        for i in 1...5 {
            station(in: pathRect, rad: 10, color: color, centr: CGPoint(x: 40, y: 20 + i*50))
            station(in: pathRect, rad: 5, color: target, centr: CGPoint(x: 40, y: 20 + i*50))
        }
        for i in 1...4 {
            path(in: pathRect, color: route, offset: i)
        }
    }
    private func station(in rect : CGRect,rad : Int, color : UIColor,centr : CGPoint) {
        let centr = centr//CGPoint(x: 40, y: 20)
        let rad = rad
        let path = UIBezierPath(arcCenter: centr, radius: CGFloat(rad), startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: false)
        path.lineWidth = 4
        let col = color//#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 0.35)
        col.setFill()
        path.fill()
    }
    private func path(in rect : CGRect, color : UIColor, offset : Int) {
           let start = CGPoint(x: 40, y: 20 + 50 * offset)
           let end = CGPoint(x: 40, y: 70 + 50 * offset)
           let path = UIBezierPath()
           path.move(to: start)
           path.addLine(to: end)
           path.lineWidth = 5
           let col = color
           col.setStroke()
           path.stroke()
       }

    private func labelDraw() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let img = renderer.image { ctx in
           let paragraphStyle = NSMutableParagraphStyle()
           paragraphStyle.alignment = .center
                    
            let attrs = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: 36)!, NSAttributedString.Key.paragraphStyle: paragraphStyle,NSAttributedString.Key.foregroundColor : UIColor.blue]
                    
           let string = "MSApps"
           string.draw(with: CGRect(x: 30, y: 30, width: 450, height: 450), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        }
    }
}
