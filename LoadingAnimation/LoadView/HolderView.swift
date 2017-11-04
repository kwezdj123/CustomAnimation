//
//  HolderView.swift
//  StudySketch&PaintCode
//
//  Created by Mr.Zhu on 2017/11/4.
//  Copyright © 2017年 Zx. All rights reserved.
//

import UIKit
protocol HolderViewDelegate:class {
    func animateLabel()
}
@IBDesignable
class HolderView: UIView {
    let ovalLayer = OvalLayer()
    let triangleLayer = TriangleLayer()
    let redRectangleLayer = RectangleLayer()
    let blueRectangleLayer = RectangleLayer()
    let arcLayer = ArcLayer()
    
    var parentFrame :CGRect = CGRect.zero
    weak var delegate:HolderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.clear
       
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    func addOval() {
        layer.addSublayer(ovalLayer)
        ovalLayer.expand()
        Timer.scheduledTimer(timeInterval: 0.3,
                                                     target: self,
                                                     selector: #selector(wobbleOval),
                                                     userInfo: nil,
                                                     repeats: false)
    }
    
    @objc func wobbleOval() {
        
        layer.addSublayer(triangleLayer)
        ovalLayer.wobble()
        Timer.scheduledTimer(timeInterval: 0.9,
                             target: self,
                             selector: #selector(addtriangle),
                             userInfo: nil,
                             repeats: false)
        
    }
    
    @objc func addtriangle(){
        triangleLayer.animate()
         Timer.scheduledTimer(timeInterval: 0.9,
                             target: self,
                             selector: #selector(spinAndTransform),
                             userInfo: nil,
                             repeats: false)
    }
    
    @objc func spinAndTransform(){
        // 1
        layer.anchorPoint = CGPoint(x:0.5, y:0.6)
        
        // 2
        let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = CGFloat(Double.pi * 2.0)
        rotationAnimation.duration = 0.45
        rotationAnimation.isRemovedOnCompletion = true
        layer.add(rotationAnimation, forKey: nil)
        //3
        ovalLayer.contract()
        
        Timer.scheduledTimer(timeInterval: 0.45,
                             target: self,
                             selector: #selector(drawRedAnimationRectangle),
                             userInfo: nil,
                             repeats: false)
        Timer.scheduledTimer(timeInterval: 0.60,
                             target: self,
                             selector: #selector(drawblueAnimationRectangle),
                             userInfo: nil,
                             repeats: false)
    }
    @objc func drawRedAnimationRectangle(){
        layer.addSublayer(redRectangleLayer)
        redRectangleLayer.animateStrokeWithColor(color: Colors.red)
    }
    @objc func drawblueAnimationRectangle(){
        layer.addSublayer(blueRectangleLayer)
        blueRectangleLayer.animateStrokeWithColor(color: Colors.blue)
        Timer.scheduledTimer(timeInterval: 0.40,
                             target: self,
                             selector: #selector(drawArc),
                             userInfo: nil,
                             repeats: false)
    }
    
    @objc func drawArc(){
    
        layer.addSublayer(arcLayer)
        arcLayer.animate()
        Timer.scheduledTimer(timeInterval: 0.90,
                             target: self,
                             selector: #selector(expandView),
                             userInfo: nil,
                             repeats: false)
    }
    
    @objc func expandView() {
        backgroundColor = Colors.blue
        frame = CGRect(x:frame.origin.x - blueRectangleLayer.lineWidth,
                       y:frame.origin.y - blueRectangleLayer.lineWidth,
                       width: frame.size.width + blueRectangleLayer.lineWidth * 2,
                       height:frame.size.height + blueRectangleLayer.lineWidth * 2)
        layer.sublayers = nil
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.frame = self.parentFrame
        }, completion: { finished in
            self.addLabel()
        })
    }
    
    func addLabel() {
        delegate?.animateLabel()
    }
}
