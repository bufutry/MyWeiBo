//
//  VisitorView.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/13.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backgroundImageView)
        addSubview(homeImageView)
        addSubview(bgMaskView)
        addSubview(contextLable)
        addSubview(registerBtn)
        addSubview(loginBtn)
        

        backgroundImageView.x = (width - backgroundImageView.width)*0.5
        backgroundImageView.y  = (height - backgroundImageView.height)*0.5
        
        bgMaskView.center = backgroundImageView.center
        
        homeImageView.center = backgroundImageView.center
        
        contextLable.width = 244
        contextLable.x = bgMaskView.x
        contextLable.y = bgMaskView.MaxY+20
        contextLable.height = 30;
        
        
        registerBtn.x = bgMaskView.x
        registerBtn.width = 100
        registerBtn.height = 30
        registerBtn.y = contextLable.MaxY+15
        
        loginBtn.frame = registerBtn.frame
        loginBtn.x = registerBtn.MaxX + 20
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:cosotmUI
    private lazy var backgroundImageView:UIImageView = {
        let bgImageView = UIImageView.init(image: UIImage.init(named: "visitordiscover_feed_image_smallicon"))
        return bgImageView
    }()
    
    private lazy var homeImageView:UIImageView = {
       let homeImageView = UIImageView.init(image: UIImage.init(named: "visitordiscover_feed_image_house"))
        return homeImageView
        
    }()
    
    private lazy var contextLable:UILabel = {
       let contextLable = UILabel()
        contextLable.textColor = UIColor.darkGrayColor()
        contextLable.numberOfLines = 0
        contextLable.textColor = UIColor.darkGrayColor()
        contextLable.text = "案件都卡机收到啦结算代理卡死机的卡拉见识到了"
        return contextLable
    }()
    
    private lazy var bgMaskView:UIImageView = {
       let bgMaskView = UIImageView.init(image: UIImage.init(named: "visitordiscover_feed_mask_smallicon"))
        return bgMaskView
    }()
    
    private lazy var registerBtn:UIButton = {
        let registerBtn = UIButton()
        registerBtn.setBackgroundImage(UIImage.init(named: "common_button_white_disable"), forState: .Normal)
        registerBtn.setTitle("注册", forState: .Normal)
        registerBtn.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        return registerBtn
    }()
    
    private lazy var loginBtn:UIButton = {
      let loginBtn  = UIButton()
        loginBtn.setBackgroundImage(UIImage.init(named: "common_button_white_disable"), forState: .Normal)
        loginBtn.setTitle("登陆", forState: .Normal)
      loginBtn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        return loginBtn
    }()
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
