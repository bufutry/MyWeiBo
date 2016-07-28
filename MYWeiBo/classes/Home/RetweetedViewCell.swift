//
//  RetweetedViewCell.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/28.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

class RetweetedViewCell: HomeTableViewCell {

   
    var pictureTopCons:NSLayoutConstraint?
    
    
    override var statuses: Statuses?
        {
        didSet{
            retweetText.text = "@" + (statuses?.retweeted_status?.user?.name)! + ":" + (statuses?.retweeted_status?.text)!
            pictureTopCons?.constant = statuses?.retweeted_status?.text == nil ? 0 : 10
        }
    }
    
    override func setupUI(){
       super.setupUI()
       contentView.insertSubview(bgBtn, belowSubview: pictureView)
       contentView.insertSubview(retweetText, aboveSubview: bgBtn)
        
         bgBtn.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView:contextView , size: nil, offset: CGPointMake(-10, 10))
         bgBtn.xmg_AlignVertical(type: XMG_AlignType.TopRight, referView:footView , size: nil)
        
         retweetText.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: bgBtn, size: nil ,offset: CGPointMake(10, 10))
       
        let cons = pictureView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: retweetText, size:CGSizeMake(10, 10),offset: CGPointMake(0, 10))
    
        pictureHeiCons = pictureView.xmg_Constraint(cons, attribute: .Height)
        pictureWitdCons = pictureView.xmg_Constraint(cons, attribute: .Width)
        pictureTopCons = pictureView.xmg_Constraint(cons, attribute: .Top)
    }
    
    private lazy var bgBtn:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.init(white: 0.9, alpha: 0.6)
       return btn
    }()
    
    private lazy var retweetText:UILabel = {
        let labe = UILabel.creatLableWith(UIColor.darkGrayColor(), fontSize: 14)
        labe.numberOfLines = 0;
        labe.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20
        return labe
    }()
    
}
