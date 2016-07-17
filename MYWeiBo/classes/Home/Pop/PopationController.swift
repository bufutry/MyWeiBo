//
//  PopationController.swift
//  MYWeiBo
//
//  Created by young on 16/7/17.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

class PopationController: UIPresentationController {

    var popFrame:CGRect = CGRectZero
    
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    }
    
    //MARK:
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        if popFrame==CGRectZero {
            presentedView()!.frame = CGRectMake(200, 50, 100, 300)
        }
        else
        {
           presentedView()!.frame = popFrame
        }
        containerView?.insertSubview(coverView, atIndex: 0)
    }
    
    private lazy var coverView:UIImageView = {
     let coverView = UIImageView()
        coverView.userInteractionEnabled = true
        coverView.frame = UIScreen.mainScreen().bounds
        coverView.backgroundColor = UIColor.init(white: 0.0, alpha: 0.2)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(close))
        coverView .addGestureRecognizer(tap)
        return coverView
    }()
    func close() {
        presentedViewController.dismissViewControllerAnimated(true) {
        }
    }
}
