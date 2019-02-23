//
//  ViewController.swift
//  LHPromptBoxTool
//
//  Created by 李辉 on 2019/2/22.
//  Copyright © 2019年 李辉. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,LHPromptBoxViewDelegate{
    var button:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        button = UIButton.init(type: UIButtonType.system)
        button.setTitle("gogogo", for: UIControlState.normal)
        button.frame = CGRect.init(x: self.view.frame.size.width/2-40, y: 50, width: 80, height: 40)
        view.addSubview(button)
        button.addTarget(self, action: #selector(btnAction(sender:)), for: UIControlEvents.touchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
    }
   @objc func btnAction(sender:UIButton) -> Void {
    
    let prompt = LHPromptBoxView()
    let mode1 = LHPromptModel()
    mode1.name = "Apple"
    
    let mode2 = LHPromptModel()
    mode2.name = "Google"
    
    let mode3 = LHPromptModel()
    mode3.name = "Cancel"
    mode3.color = UIColor.red
    
    prompt.modelArray = [mode1,mode2,mode3]
    prompt.lh_show()
    prompt.delegate = self
    //如果有闭包的实现，会优先执行闭包。
    prompt.selectBlock = {(index:Int)->Void in
        print(index)
    }
    }
    
    //点击方法
    func lh_didSelet(index: Int) {
        print(index)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

