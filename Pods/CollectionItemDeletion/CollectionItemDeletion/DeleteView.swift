//
//  DeleteView.swift
//  FacebookPopupDeletion
//
//  Created by Abdul Rahman on 4/7/19.
//  Copyright © 2019 Abdul Rahman. All rights reserved.
//

import UIKit
class DeleteView: UIView {
    
    var backGroundView:UIView?
    var circleView:UIView?
    let circleLayer = CAShapeLayer()
    let XLayer = CAShapeLayer()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        initBackgroundView()
        initCircleLayer()
        initXLayer()
    }
    
    
    func initBackgroundView()  {
        backGroundView = UIView(frame: bounds)
        backGroundView!.backgroundColor = .black
        backGroundView?.layer.cornerRadius = 25
        backGroundView!.alpha = 0.3
        backGroundView!.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        self.addSubview(backGroundView!)
    }
    
    
    func initCircleLayer()  {
        circleView = UIView(frame: bounds)
        circleView?.layer.cornerRadius = 25
        circleView!.backgroundColor = .clear
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2), radius: 23.5, startAngle: 0, endAngle: 2*3.14, clockwise: true)
        circleLayer.path = path.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = 1.5
        circleView!.layer.addSublayer(circleLayer)
        self.addSubview(circleView!)
    }
    
    
    func initXLayer()  {
        let path = UIBezierPath()
        let scale:CGFloat = 10
        path.move(to: CGPoint(x: self.frame.size.width/2 - scale  , y: self.frame.size.height/2 - scale))
        path.addLine(to: CGPoint(x: self.frame.size.width/2 + scale  , y: self.frame.size.height/2 + scale))
        path.move(to: CGPoint(x: self.frame.size.width/2 + scale  , y: self.frame.size.height/2 - scale))
        path.addLine(to: CGPoint(x: self.frame.size.width/2 - scale  , y: self.frame.size.height/2 + scale))
        XLayer.path = path.cgPath
        XLayer.fillColor = UIColor.clear.cgColor
        XLayer.strokeColor = UIColor.white.cgColor
        XLayer.lineWidth = 1.5
        self.layer.addSublayer(XLayer)
    }
    
    
    func swallowCircleAnimation()  {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2,
                                                       delay: 0,
                                                       options: [],
                                                       animations: {
                                                        self.circleView?.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
                                                        self.backGroundView?.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
        }) { (position) in
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1,
                                                           delay: 0,
                                                           options: [],
                                                           animations: {
                                                            self.circleView?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                                                            self.backGroundView?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            })
        }
    }
    
    func releaseCircleAnimation()  {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2,
                                                       delay: 0,
                                                       options: [],
                                                       animations: {
                                                        self.circleView?.transform = CGAffineTransform.identity
                                                        self.backGroundView?.transform = CGAffineTransform.identity
        })
    }
    
    
    

}
