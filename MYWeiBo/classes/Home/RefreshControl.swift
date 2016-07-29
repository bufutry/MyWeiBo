//
//  RefreshControl.swift
//  MYWeiBo
//
//  Created by 杨绍鑫 on 16/7/28.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

class RefreshControl: UIRefreshControl {

    
    override init() {
        super.init()
        setupUI()
        addObserver(self, forKeyPath: "frame", options: .New, context: nil)
    }
    
    private  func setupUI()  {
        addSubview(refreshView)
        
        refreshView.xmg_AlignInner(type: XMG_AlignType.Center, referView: self, size: CGSizeMake(170, 44))
    }
    
    override func endRefreshing() {
        super.endRefreshing()
        
        refreshView.stopCysAnimation()
        
        loadingViewAnimFlag = true
    }

    
    var isArrow = false
    var loadingViewAnimFlag = true
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        let value = frame.origin.y
        
        if value >= 0 {
            return
        }
        
        if refreshing && loadingViewAnimFlag {
            loadingViewAnimFlag = false
            refreshView.cysAnimation()
        }
        
        if value < -60 && isArrow{
            refreshView.arrowAnimation(isArrow)
            isArrow = false
        }
        else if value >= -60 && !isArrow
        {
            refreshView.arrowAnimation(isArrow)
            isArrow = true
        }
    }
    
    private lazy var refreshView:RefreshHeadView = RefreshHeadView.refreshView()
    
    deinit{
       removeObserver(self, forKeyPath: "frame")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RefreshHeadView: UIView {
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var cycView: UIImageView!
    @IBOutlet weak var arrowView: UIImageView!
    
   class  func refreshView() -> RefreshHeadView {
    
        return  (NSBundle.mainBundle().loadNibNamed("RefreshHeadView", owner: nil, options: nil).last! as? RefreshHeadView)!
    }
    
    func arrowAnimation(isArrow:Bool)  {
        
        let angle:CGFloat = CGFloat(M_PI)
        UIView.animateWithDuration(0.5) { 
            self.arrowView.transform = CGAffineTransformRotate(self.arrowView.transform,angle)
        }
    }
    
    func cysAnimation()  {
        loadingView.hidden = false
        let anima = CABasicAnimation.init(keyPath: "ratation.x")
        anima.toValue = M_2_PI
        anima.repeatCount = MAXFLOAT
        cycView.layer.addAnimation(anima, forKey:nil)
        
    }
    
    func stopCysAnimation()  {
        loadingView.hidden = true
        cycView.layer.removeAllAnimations()
    }
    
    
}