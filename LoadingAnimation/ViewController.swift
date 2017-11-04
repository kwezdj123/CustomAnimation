//
//  ViewController.swift
//  LoadingAnimation
//
//  Created by Mr.Zhu on 2017/11/4.
//  Copyright © 2017年 Zx. All rights reserved.
//

import UIKit

class ViewController: UIViewController,HolderViewDelegate {

    func animateLabel() {
        
        holderView.removeFromSuperview()
        view.backgroundColor = Colors.blue
        
        // 2
        var label: UILabel = UILabel(frame: view.frame)
        label.textColor = Colors.white
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 170.0)
        label.textAlignment = NSTextAlignment.center
        label.text = "S"
        label.transform = CGAffineTransform.init(scaleX: 0.25, y: 0.25)
        view.addSubview(label)
        
        // 3
        UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.curveEaseInOut,
                       animations: ({
                        label.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
                       }), completion: { finished in
                        self.addButton()
        })
    }
    
    
    var holderView = HolderView(frame:CGRect.zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.white
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addHolderView()
   
    }
    
    func addHolderView() {
        let boxSize: CGFloat = 100.0
        holderView.frame = CGRect(x: view.bounds.width / 2 - boxSize / 2,
                                  y: view.bounds.height / 2 - boxSize / 2,
                                  width: boxSize,
                                  height: boxSize)
        holderView.parentFrame = view.frame
        holderView.delegate = self
        view.addSubview(holderView)
        holderView.addOval()
    }
    
    func addButton() {
        let button = UIButton()
        button.frame = CGRect(x:0.0, y:0.0, width:view.bounds.width, height:view.bounds.height)
        button.addTarget(self, action:#selector(buttonPressed(sender:)), for: .touchUpInside)
        button.backgroundColor = Colors.blue
        view.addSubview(button)
    }
    
    @objc func buttonPressed(sender: UIButton!) {
        view.backgroundColor = Colors.white
        _ = view.subviews.map {$0.removeFromSuperview()}
        holderView = HolderView(frame: CGRect.zero)
        addHolderView()
    }
    

}

