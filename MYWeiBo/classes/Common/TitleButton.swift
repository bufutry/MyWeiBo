//
//  TitleButton.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/14.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

class TitleButton: UIButton {
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        setImage(UIImage.init(named: "navigationbar_arrow_down"), forState: .Normal)
        setImage(UIImage.init(named: "navigationbar_arrow_up"), forState: .Selected)
        sizeToFit()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.x = 0
        imageView?.x = (titleLabel?.frame.width)!
    }
}
