//
//  HomeTableViewCell.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/25.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    var statuses:Statuses?{
        didSet{
            topView.statuse = statuses
            contextView.text = statuses?.text
            pictureView.statuse = statuses
            pictureView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: contextView, size: pictureView.calculationSize() ,offset: CGPointMake(0, 10))
            statuses?.cellHeight = CGRectGetMaxY(footView.frame)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(topView)
        contentView.addSubview(contextView)
        contentView.addSubview(pictureView)
        contentView.addSubview(footView)
        
        
        let with = UIScreen.mainScreen().bounds.width
        
        
        topView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: contentView, size: CGSizeMake(with, 60), offset: CGPointMake(0, 0))
        contextView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: topView, size: nil, offset: CGPointMake(10, 10))
        pictureView.xmg_AlignVertical(type: XMG_AlignType.BottomCenter, referView: contextView, size: nil,offset: CGPointMake(0, 10))
        footView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: pictureView, size: CGSizeMake(with, 30), offset: CGPointMake(-10, 10))
        

    }
    
    func cellHight(statuses:Statuses) -> CGFloat {
//         topView.statuse = statuses
//        contextView.text = statuses.text
//        pictureView.statuse = statuses
//        pictureView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: contextView, size: pictureView.calculationSize() ,offset: CGPointMake(0, 10))
//        statuses.cellHeight = CGRectGetMaxY(footView.frame)
//        contentView.layoutIfNeeded()
//        return CGRectGetMaxY(footView.frame)
        return 300
    }
        /// 用户信息
    private lazy var topView:StatuseTopView = StatuseTopView()
    
    private lazy var contextView:UILabel = {
        let labe = UILabel.creatLableWith(UIColor.darkGrayColor(), fontSize: 14)
        labe.numberOfLines = 0;
        labe.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20
        return labe
        
    }()
    
    
    private lazy var pictureView:StatusePictureView = StatusePictureView()
    
    private lazy var footView:StatuseFooterView = StatuseFooterView()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
