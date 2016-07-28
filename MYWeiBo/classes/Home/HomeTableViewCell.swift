//
//  HomeTableViewCell.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/25.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

enum HomeTableViewCellIdentifier:String {
    case normalr = "normalrIdentifier"
    case retweeted = "retweetedIdentifier"
    
    static func cellIdentifier(status:Statuses) ->String{
        if status.retweeted_status==nil {
            return normalr.rawValue
        }
        else
        {
           return retweeted.rawValue
        }
    }
}

class HomeTableViewCell: UITableViewCell {

    var pictureHeiCons:NSLayoutConstraint?
    var pictureWitdCons:NSLayoutConstraint?
    
    
    var statuses:Statuses?{
        didSet{
            topView.statuse = statuses
            contextView.text = statuses?.text
            pictureView.imageArray = statuses?.picList
            let size = pictureView.calculationSize()
            pictureWitdCons?.constant = size.width
            pictureHeiCons?.constant = size.height
       }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        }
    
    func setupUI()  {
        contentView.addSubview(topView)
        contentView.addSubview(contextView)
        contentView.addSubview(pictureView)
        contentView.addSubview(footView)
        
        
        let with = UIScreen.mainScreen().bounds.width
        
        
        topView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: contentView, size: CGSizeMake(with, 60), offset: CGPointMake(0, 0))
        contextView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: topView, size: nil, offset: CGPointMake(10, 10))
//        let cons = pictureView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: contextView, size: CGSizeZero,offset: CGPointMake(0, 10))
//        pictureHeiCons = pictureView.xmg_Constraint(cons, attribute: .Height)
//        pictureWitdCons = pictureView.xmg_Constraint(cons, attribute: .Width)
        footView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: pictureView, size: CGSizeMake(with, 30), offset: CGPointMake(-10, 10))

    }
    
    func cellHight(statuses:Statuses) -> CGFloat {
        
        self.statuses = statuses
        contentView.layoutIfNeeded()
        self.statuses?.cellHeight = CGRectGetMaxY(footView.frame)
        return CGRectGetMaxY(footView.frame)
    }
        /// 用户信息
    private lazy var topView:StatuseTopView = StatuseTopView()
    
     lazy var contextView:UILabel = {
        let labe = UILabel.creatLableWith(UIColor.darkGrayColor(), fontSize: 14)
        labe.numberOfLines = 0;
        labe.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20
        return labe
    }()
    
    
    lazy var pictureView:StatusePictureView = StatusePictureView()
    
    lazy var footView:StatuseFooterView = StatuseFooterView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
