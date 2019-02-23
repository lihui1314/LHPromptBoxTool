//
//  LHTouchView.swift
//  LHPromptBoxTool
//
//  Created by 李辉 on 2019/2/22.
//  Copyright © 2019年 李辉. All rights reserved.
//

import UIKit
@objc protocol LHTouchViewDelegate:NSObjectProtocol {
   @objc func lh_touchAction(viewTag:Int) -> Void
   @objc optional func lh_touchBegin() -> Void
   @objc optional func lh_touchEnd() -> Void
}
class LHTouchView: UIView {
    var viewState :Int?
    var viewTag :Int?
    var backColor:UIColor?
    weak var delegate: LHTouchViewDelegate?
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.backColor = self.backgroundColor
        self.backgroundColor = UIColor.groupTableViewBackground
        if (self.delegate?.responds(to: #selector(LHTouchViewDelegate.lh_touchBegin)))!{
            self.delegate?.lh_touchBegin!()
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.backgroundColor = self.backColor
        let touch = (touches as NSSet).anyObject()
        let tPoint = (touch as! UITouch).location(in: self)
        let rect = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height);
        
        let judgePoint = rect.contains(tPoint)
        if judgePoint {
            if  (self.delegate?.responds(to: #selector(LHTouchViewDelegate.lh_touchAction(viewTag:))))! {
                self.delegate?.lh_touchAction(viewTag: viewTag!)
            }
            if(self.delegate?.responds(to: #selector(LHTouchViewDelegate.lh_touchEnd)))!{
                self.delegate?.lh_touchEnd!()
            }
           
        }else{
            if(self.delegate?.responds(to: #selector(LHTouchViewDelegate.lh_touchEnd)))!{
                self.delegate?.lh_touchEnd!()
            }
        }

        
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.delegate?.responds(to: #selector(LHTouchViewDelegate.lh_touchEnd)))! {
            self.delegate?.lh_touchEnd!()
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
