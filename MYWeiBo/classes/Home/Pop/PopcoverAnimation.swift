//
//  PopcoverAnimation.swift
//  MYWeiBo
//
//  Created by young on 16/7/17.
//  Copyright © 2016年 Y. All rights reserved.
//

import UIKit

let PresentationControlleWillShow = "PresentationControlleWillShow"
let PresentationControlleWillHidden = "PresentationControlleWillHidden"


class PopcoverAnimation: NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning{
  
    var isPresent:Bool = true
    var popFrame = CGRectZero
    
    
    //MARK: - TransitioningDelegate
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        let presentVC =  PopationController.init(presentedViewController: presented, presentingViewController: presenting)
         presentVC.popFrame = popFrame
         return presentVC
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        NSNotificationCenter.defaultCenter() .postNotificationName(PresentationControlleWillShow, object: nil)
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        NSNotificationCenter.defaultCenter().postNotificationName(PresentationControlleWillHidden, object: nil)
        return self
    }
    
    //MARK: - Anima
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if isPresent==true {
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
            toView?.layer.anchorPoint = CGPointMake(0.5, 0)
            toView?.transform = CGAffineTransformMakeScale(1, 0)
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { 
                    toView?.transform = CGAffineTransformMakeScale(1, 1)
                }, completion: { (_) in
                    transitionContext.completeTransition(true)
            })
            transitionContext.containerView()?.addSubview(toView!)
        }
        else
        {
          let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
             transitionContext.containerView()?.addSubview(fromView!)
            fromView?.layer.anchorPoint = CGPointMake(0.5, 0)
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                fromView?.transform = CGAffineTransformMakeScale(1, 0.00001)
                }, completion: { (_) in
                    transitionContext.completeTransition(true)
            })
        }
    }
}
