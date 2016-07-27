//
//  StatuseTopView.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/26.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

class StatuseTopView: UIView {
    
    var statuse:Statuses?{
        didSet{
         name.text = statuse?.user?.name
         avtarView.sd_setImageWithURL(statuse!.user!.av_url!)
         time.text = statuse?.dateDesc
         vipImage.image = statuse?.user?.vipImage
         source.text = statuse?.source
         markView.image = statuse?.user?.verifiedImage
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI(){
     addSubview(avtarView)
     addSubview(vipImage)
     addSubview(markView)
     addSubview(name)
     addSubview(time)
     addSubview(source)
        
        avtarView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: self, size: CGSizeMake(50, 50), offset: CGPointMake(10, 10))
        name.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: avtarView, size: nil ,offset: CGPointMake(10, 0))
        vipImage.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: name, size: CGSizeMake(14, 14), offset: CGPointMake(5, 0))
        markView.xmg_AlignInner(type: XMG_AlignType.BottomRight, referView: avtarView, size: CGSizeMake(14, 14))
        time.xmg_AlignHorizontal(type: XMG_AlignType.BottomRight, referView: avtarView, size: nil, offset: CGPointMake(10, 0))
        source.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: time, size: nil ,offset: CGPointMake(10, 0))

    }
    
    
    /// 头像
    private lazy var avtarView:UIImageView = {
        let image = UIImageView()
        image.image = UIImage.init(named: "avatar_default")
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        return image
    }()
    
        /// 姓名
    private lazy var name:UILabel = {
        return UILabel.creatLableWith(UIColor.darkTextColor(), fontSize: 14)
    }()
    
        /// 时间
    private lazy var time:UILabel = {
      return UILabel.creatLableWith(UIColor.darkTextColor(), fontSize: 14)
    }()
    
        /// 来源
    private lazy var source:UILabel = {
      return UILabel.creatLableWith(UIColor.darkTextColor(), fontSize: 14)
    }()
    
        /// vip
    private lazy var vipImage:UIImageView = {
        let image = UIImageView()
        return image
    }()
        /// 认证
    private lazy var markView:UIImageView = {
        let image = UIImageView()
        return image
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
