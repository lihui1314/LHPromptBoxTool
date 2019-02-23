//
//  LHPromptBoxViewCell.swift
//  LHPromptBoxTool
//
//  Created by 李辉 on 2019/2/22.
//  Copyright © 2019年 李辉. All rights reserved.
//

import UIKit

class LHPromptBoxViewCell: LHTouchView {
    var label :UILabel?
    var model : LHPromptModel?{
        didSet{
            label?.text = model?.name
            label?.textColor = model?.color
        }
    }
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        label?.textAlignment = NSTextAlignment.center
        self.addSubview(label!)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
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
class LHPromptModel: NSObject {
    var name:String?
    var color:UIColor?
}
