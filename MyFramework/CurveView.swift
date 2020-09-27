//
//  CurveView.swift
//  iManager
//
//  Created by Mohamed Shemy on 18 Sep, 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import UIKit

@IBDesignable
open class CurveView: UIView
{
    @IBInspectable public var curveColor: UIColor = .systemBlue
    {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var curveHeight: CGFloat = 50.0
    {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var heightMultiplier: CGFloat = 0.6
    {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    public override func layoutSubviews()
    {
        super.layoutSubviews()
        drawBackground()
    }
    
    func drawBackground()
    {
        let screenWidth = self.frame.width
        let screenHeight = self.frame.height
        let offsetY: CGFloat = screenHeight * min(heightMultiplier, 1.0)
        
        let rect = CGRect(x: 0, y: 0, width: screenWidth, height: offsetY)
        let path = UIBezierPath(rect: rect)
        
        let curve = drawCurve(curveHight: curveHeight, maxPoint: CGPoint(x: screenWidth, y: offsetY))
        path.append(curve)
        
        let layer = CAShapeLayer()
        
        layer.fillColor = curveColor.cgColor
        layer.strokeColor = curveColor.cgColor
        layer.path = path.cgPath
        self.layer.addSublayer(layer)
    }
    
    func drawCurve(curveHight: CGFloat, maxPoint: CGPoint) -> UIBezierPath
    {
        let path = UIBezierPath()
        
        let p0 = CGPoint(x: 0, y: maxPoint.y)
        let p2 = CGPoint(x: maxPoint.x, y: maxPoint.y)
        let p1 = CGPoint(x: maxPoint.x / 2.0, y: maxPoint.y + curveHight)
        
        path.move(to: p0)
        path.addQuadCurve(to: p2, controlPoint: p1)
        return path
    }
}
