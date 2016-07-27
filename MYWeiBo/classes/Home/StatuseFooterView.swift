//
//  StatuseFooterView.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/26.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

class StatuseFooterView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 0.2, alpha: 0.5)
        setupUI()
    }
    
    private func setupUI()
    {
        addSubview(retweetBtn)
        addSubview(commentBtn)
        addSubview(likeBtn)
        
        xmg_HorizontalTile([retweetBtn,commentBtn,likeBtn], insets: UIEdgeInsetsMake(0, 0, 0, 0))
    
    }
    
    
    private lazy var retweetBtn:UIButton = {
      return UIButton.creatWith("转发", image: "timeline_icon_retweet")
    }()
    
    private lazy var commentBtn:UIButton = {
        return UIButton.creatWith("评论", image: "timeline_icon_comment")
    }()
    
    private lazy var likeBtn:UIButton = {
        return UIButton.creatWith("转发", image: "timeline_icon_unlike")
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
