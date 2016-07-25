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
          
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avtarView)
        
        
        avtarView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: contentView, size: CGSizeMake(60, 60), offset: CGPointMake(10, 10))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        /// 头像
    private lazy var avtarView:UIImageView = {
      let image = UIImageView()
      return image
    }()
}
