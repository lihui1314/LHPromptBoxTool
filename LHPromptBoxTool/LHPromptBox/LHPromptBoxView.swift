//
//  LHPromptBoxView.swift
//  LHPromptBoxTool
//
//  Created by 李辉 on 2019/2/22.
//  Copyright © 2019年 李辉. All rights reserved.
//

import UIKit
let height:CGFloat = 50
let cancelPadding:CGFloat = 3
let screenWidth:CGFloat = UIScreen.main.bounds.size.width
let screenHeight:CGFloat = UIScreen.main.bounds.size.height
let needSafeA = (screenHeight>CGFloat(737)) ? true:false
typealias LHBlock = (_ tag:Int)->Void

@objc protocol LHPromptBoxViewDelegate:NSObjectProtocol{
    @objc func lh_didSelet(index:Int) -> Void
}
class LHPromptBoxView: UIView,LHTouchViewDelegate{
    func lh_touchAction(viewTag: Int) {
        if (self.selectBlock != nil){
            selectBlock!(viewTag)
        }else{
              self.delegate.lh_didSelet(index: viewTag)
        }
        removeAllSubViews()
    }
    func lh_touchBegin() {
       allBacView.removeGestureRecognizer(gesture)
    }
    
    weak var delegate:LHPromptBoxViewDelegate!
    var modelArray :Array<LHPromptModel>!
    var cellBackView :UIView!
    var allBacView:UIView!
    var gesture :UITapGestureRecognizer!
    var  selectBlock: ((_ tag:Int)->Void)?
    
    func lh_show() -> Void {
        allBacView = UIView.init(frame: UIScreen.main.bounds)
        allBacView.backgroundColor = UIColor.black.withAlphaComponent(0)
        gesture = UITapGestureRecognizer.init(target: self, action: #selector(gestureAc))
        allBacView.addGestureRecognizer(gesture)
        let count = modelArray.count
        let viewHeight = height*(CGFloat(count))+CGFloat(count)-1 + CGFloat(cancelPadding)

        cellBackView = UIView.init(frame: CGRect.init(x: 0, y:screenHeight, width:screenWidth, height: viewHeight))
        UIView.animate(withDuration: 0.3) {
            self.cellBackView.frame = CGRect.init(x:0, y: screenHeight - viewHeight - self.needSafeArea(), width: screenWidth, height: viewHeight)
            self.allBacView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        }
        cellBackView.backgroundColor = UIColor.groupTableViewBackground
        for index in(0...count-1).reversed() {
            var h :CGFloat=0
            if(index == count-1){
            h = CGFloat(index)*height+CGFloat(index)+cancelPadding
            }else{
               h = CGFloat(index)*height+CGFloat(index)
            }
            let cell = LHPromptBoxViewCell.init(frame: CGRect.init(x: 0, y: h, width: screenWidth, height: height))
            cell.model = modelArray[index]
            cell.delegate = self
            cell.viewTag = index
            cellBackView.addSubview(cell)
            
        }
        allBacView.addSubview(cellBackView)
        //
        let app = UIApplication.shared
        app.delegate?.window!?.addSubview(allBacView)
        app.delegate?.window!?.addSubview(self)
    }
    
    private func removeAllSubViews() -> Void {
        let deadline = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.removeFromSuperview()
            self.allBacView.removeFromSuperview()
        }
        UIView.animate(withDuration: 0.3) {
           self.allBacView.backgroundColor = UIColor.black.withAlphaComponent(0)
           let center =  self.cellBackView.center
           let newCenter = CGPoint.init(x: center.x, y: center.y+self.cellBackView.frame.size.height+self.needSafeArea())
           self.cellBackView.center = newCenter
        }
        
    }
    
   @objc func gestureAc() -> Void {
        removeAllSubViews()
    }
    func needSafeArea() -> CGFloat {
        if needSafeA {
            return 34
        }else{
            return 0
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
