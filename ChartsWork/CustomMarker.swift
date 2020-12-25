//
//  CustomMarker.swift
//  ChartsWork
//
//  Created by Gag Mkrtchyan on 16.11.20.
//

import UIKit
import Charts

class CustomMarker: MarkerView {
    
    var text = ""
    
    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        super.refreshContent(entry: entry, highlight: highlight)
        text = String(entry.y)
        
        let valueArray = text.components(separatedBy: ".")
        if valueArray[1] == "0" {
            text = valueArray[0]
        }
    }
    
    override func draw(context: CGContext, point: CGPoint) {
        super.draw(context: context, point: point)
        
        var drawAttributes = [NSAttributedString.Key : Any]()
        drawAttributes[.font] = UIFont.systemFont(ofSize: 15)
        drawAttributes[.foregroundColor] = UIColor.black
        drawAttributes[.backgroundColor] = UIColor.white
        
        
        
        self.bounds.size = (" \(text) " as NSString).size(withAttributes: drawAttributes)
        self.offset = CGPoint(x: -10, y: -self.bounds.size.height - 25)
        
        let offset = self.offsetForDrawing(atPoint: point)
        
        drawText(text: " \(text) " as NSString, rect: CGRect(origin: CGPoint(x: point.x + offset.x, y: point.y + offset.y), size: self.bounds.size), withAttributes: drawAttributes)
        
    }
    
    func drawText(text: NSString, rect: CGRect, withAttributes attributes: [NSAttributedString.Key : Any]? = nil) {
        let size = text.size(withAttributes: attributes)
        let centeredRect = CGRect(x: rect.origin.x + (rect.size.width - size.width) / 2.0, y: rect.origin.y + (rect.size.height - size.height) / 2.0, width: size.width, height: size.height)
        text.draw(in: centeredRect, withAttributes: attributes)
        
        let path = UIBezierPath()
        let radius: CGFloat = centeredRect.height * 0.2
        let z: CGFloat = 10
        let origin = CGPoint(x: centeredRect.origin.x - z, y: centeredRect.origin.y - z)//centeredRect.origin
        let width = centeredRect.width + (z * 2)
        let height = centeredRect.height + (z * 2)
        
        path.move(to: CGPoint(x: origin.x + radius, y: origin.y))
        path.addLine(to: CGPoint(x: origin.x + width - radius, y: origin.y))
        path.addArc(withCenter: CGPoint(x: origin.x + width - radius, y: origin.y + radius), radius: radius, startAngle: -.pi/2, endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: origin.x + width, y: origin.y + height - radius))
        path.addArc(withCenter: CGPoint(x: origin.x + width - radius, y: origin.y + height - radius), radius: radius, startAngle: 0, endAngle: .pi / 2, clockwise: true)
        path.addLine(to: CGPoint(x:(origin.x + width / 2) + radius, y: origin.y + height))
        path.addLine(to: CGPoint(x:origin.x + width / 2, y: origin.y + height + radius))
        path.addLine(to: CGPoint(x: (origin.x + width / 2) - radius, y: origin.y + height))
        path.addLine(to: CGPoint(x: origin.x + radius, y: origin.y + height))
        path.addArc(withCenter: CGPoint(x: origin.x + radius, y: origin.y + height - radius), radius: radius, startAngle: .pi/2, endAngle: .pi, clockwise: true)
        path.addLine(to: CGPoint(x: origin.x, y: origin.y + radius))
        path.addArc(withCenter: CGPoint(x: origin.x + radius, y: origin.y + radius), radius: radius, startAngle: .pi, endAngle: -.pi/2, clockwise: true)
        
        
        UIColor.link.setStroke()
        path.stroke()
        
        
    }
}


