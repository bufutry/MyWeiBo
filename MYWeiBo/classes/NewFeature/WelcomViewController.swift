//
//  WelcomViewController.swift
//  MYWeiBo
//
//  Created by young on 16/7/23.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        avImageView.frame = CGRectMake(0, 80, 90, 90)
        avImageView.center = view.center
        avImageView.y = 40
        bagImageView.frame = UIScreen.mainScreen().bounds
        messageLabel.frame = CGRectMake(0, CGRectGetMaxY(avImageView.frame)+40, view.width, 30)
       
        view.addSubview(bagImageView)
        view.addSubview(avImageView)
        view.addSubview(messageLabel)
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        avImageView.y = UIScreen.mainScreen().bounds.size.height
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            // 头像动画
            self.avImageView.y = 80
        }) { (_) -> Void in
            
            // 文本动画
            UIView.animateWithDuration( 2.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
                self.messageLabel.alpha = 1.0
                }, completion: { (_) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName(NeedReturnMainVC, object: nil)
            })
        }

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private lazy var avImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 45
        imageView.sd_setImageWithURL(NSURL.init(string: (currentAcount?.profile_image_url)!), placeholderImage: UIImage.init(named: "avatar_default_big"), options: .RetryFailed)
        return imageView
        }()
    
    private lazy var bagImageView:UIImageView = {
     let bgImageView = UIImageView()
        bgImageView.image = UIImage.init(named: "ad_background")
        return bgImageView
    }()
    
    private lazy var messageLabel:UILabel = {
      let lable = UILabel()
        lable.text = "欢迎回来"
        lable.textAlignment = NSTextAlignment.Center
        return lable
    }()
}
