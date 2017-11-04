//
//  TriangleLayer.swift
//  StudySketch&PaintCode
//
//  Created by Mr.Zhu on 2017/11/4.
//  Copyright © 2017年 Zx. All rights reserved.
//

import UIKit
@IBDesignable
class TriangleLayer: CAShapeLayer {

    let innerPadding: CGFloat = 30.0
    
    override init() {
        super.init()
        fillColor = Colors.red.cgColor
        strokeColor = Colors.red.cgColor
        lineWidth = 7.0
        lineCap = kCALineCapRound
        lineJoin = kCALineJoinRound
        path = trianglePathSmall.cgPath
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var trianglePathSmall: UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 5.0 + innerPadding, y: 95.0))
        trianglePath.addLine(to: CGPoint(x: 50.0, y: 12.5 + innerPadding))
        trianglePath.addLine(to: CGPoint(x: 95.0 - innerPadding, y: 95.0))
        trianglePath.close()
        return trianglePath
    }
    
    var trianglePathLeftExtension: UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 5.0, y: 95.0))
        trianglePath.addLine(to: CGPoint(x: 50.0, y: 12.5 + innerPadding))
        trianglePath.addLine(to: CGPoint(x: 95.0 - innerPadding, y: 95.0))
        trianglePath.close()
        return trianglePath
    }
    
    var trianglePathRightExtension: UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 5.0, y: 95.0))
        trianglePath.addLine(to: CGPoint(x: 50.0, y: 12.5 + innerPadding))
        trianglePath.addLine(to: CGPoint(x: 95.0, y: 95.0))
        trianglePath.close()
        return trianglePath
    }
    
    var trianglePathTopExtension: UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 5.0, y: 95.0))
        trianglePath.addLine(to: CGPoint(x: 50.0, y: 12.5))
        trianglePath.addLine(to: CGPoint(x: 95.0, y: 95.0))
        trianglePath.close()
        return trianglePath
    }
    
    func animate() {
        
        let triangleAnimLeft: CABasicAnimation = CABasicAnimation(keyPath: "path")
        triangleAnimLeft.beginTime = 0.0
        triangleAnimLeft.duration = 0.3
        triangleAnimLeft.fromValue = trianglePathSmall.cgPath
        triangleAnimLeft.toValue = trianglePathLeftExtension.cgPath
       

        let triangleAnimRight: CABasicAnimation = CABasicAnimation(keyPath: "path")
        triangleAnimRight.beginTime = triangleAnimLeft.beginTime+triangleAnimLeft.duration
        triangleAnimRight.duration = 0.25
        triangleAnimRight.fromValue = trianglePathLeftExtension.cgPath
        triangleAnimRight.toValue = trianglePathRightExtension.cgPath
        

        let triangleAnimTop: CABasicAnimation = CABasicAnimation(keyPath: "path")
        triangleAnimTop.beginTime = triangleAnimRight.beginTime+triangleAnimRight.duration
        triangleAnimTop.duration = 0.20
        triangleAnimTop.fromValue = trianglePathRightExtension.cgPath
        triangleAnimTop.toValue = trianglePathTopExtension.cgPath
       
        let triangleAnimationGroup: CAAnimationGroup = CAAnimationGroup()
        triangleAnimationGroup.animations = [triangleAnimLeft,triangleAnimRight,triangleAnimTop]
        triangleAnimationGroup.duration = triangleAnimTop.beginTime + triangleAnimTop.duration
        triangleAnimationGroup.fillMode = kCAFillModeForwards
        triangleAnimationGroup.isRemovedOnCompletion = false
        add(triangleAnimationGroup, forKey: nil)
        
   
        
    }
    
}
