//
//  VisitorView.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/13.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

protocol VisitorViewDelegat:NSObjectProtocol {
    func visitorViewRegistClick()
    func visitorViewLoginClick()
}

class VisitorView: UIView {

    weak var delegat:VisitorViewDelegat?
    
    func setupInfo(isHome:Bool ,messgae:String ,imgeName:String) -> () {
        backgroundImageView.hidden = !isHome
        homeImageView.image = UIImage.init(named: imgeName)
        contextLable.text = messgae
        isHome ? setupAnimation():()
    }
    
   private func setupAnimation() {
        let animation = CABasicAnimation.init()
        animation.keyPath = "transform.rotation"
        animation.toValue = 2 * M_PI
        animation.repeatCount  = MAXFLOAT;
        animation.duration = 12
        animation.removedOnCompletion = false
        backgroundImageView.layer.addAnimation(animation, forKey: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backgroundImageView)
        addSubview(homeImageView)
        addSubview(bgMaskView)
        addSubview(contextLable)
        addSubview(registerBtn)
        addSubview(loginBtn)
        
        

        backgroundImageView.xmg_AlignInner(type: .Center, referView: self, size: nil)
        homeImageView.xmg_AlignInner(type: .Center, referView: self, size: nil)
        
        contextLable.xmg_AlignVertical(type: XMG_AlignType.BottomCenter, referView: backgroundImageView, size: nil)
        
        let width = NSLayoutConstraint.init(item: contextLable, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: 244)
        addConstraint(width)
        
        registerBtn.xmg_AlignVertical(type: .BottomLeft, referView: contextLable, size: CGSizeMake(100, 30), offset: CGPointMake(0, 20))
        
        loginBtn.xmg_AlignVertical(type: .BottomRight, referView: contextLable, size: CGSizeMake(100, 30), offset: CGPointMake(0, 20))
        
        bgMaskView.xmg_Fill(self)

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func registClick() {
        delegat?.visitorViewRegistClick()
    }
    func loginClick()  {
        delegat?.visitorViewLoginClick()
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
        registerBtn.addTarget(self, action:#selector(registClick), forControlEvents: .TouchUpInside)
        return registerBtn
    }()
    
    private lazy var loginBtn:UIButton = {
      let loginBtn  = UIButton()
        loginBtn.setBackgroundImage(UIImage.init(named: "common_button_white_disable"), forState: .Normal)
        loginBtn.setTitle("登陆", forState: .Normal)
      loginBtn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        loginBtn.addTarget(self, action:#selector(loginClick), forControlEvents: .TouchUpInside)
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
