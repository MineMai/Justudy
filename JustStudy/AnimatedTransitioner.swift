//
//  MovieTransitioner.swift
//  MovieSelectr
//
//  Created by Training on 10/10/2016.
//  Copyright © 2016 Training. All rights reserved.
//

import UIKit

class AnimatedTransitioning:NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresentation = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }

    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        //設定從哪裡到哪裡的VC
        let fromVC = transitionContext.viewController(forKey: .from)
        let fromView = fromVC!.view
        
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC!.view
        
        //設定一個容器view
        let containerView = transitionContext.containerView
        
        //把fromVC、toVC 加進這個容器view裡面
        if isPresentation {
            containerView.addSubview(toView!)
        }
        
        //判斷現在是要呈現或消失，就選用toVC 或 fromVC
        let animatingVC = isPresentation ? toVC : fromVC
        
        //所以就拿到了animatingView
        let animatingView = animatingVC!.view
        
        //設定frame
        let appearedFrame = transitionContext.finalFrame(for: animatingVC!)
        var dismissedFrame = appearedFrame
        
        dismissedFrame.origin.y += dismissedFrame.size.height
        
        //動畫的移動
        let initialFrame = isPresentation ? dismissedFrame : appearedFrame
        let finalFrame = isPresentation ? appearedFrame : dismissedFrame
        
        animatingView?.frame = initialFrame
        
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 300, initialSpringVelocity: 5, options: [.allowUserInteraction, .beginFromCurrentState], animations: { 
            animatingView?.frame = finalFrame
            
            if !self.isPresentation {
                animatingView?.alpha = 0
            }
            
        }) { (success:Bool) in
            if !self.isPresentation {
                fromView?.removeFromSuperview()
            }
            
            transitionContext.completeTransition(true)
        }
        
    }
    
}


class TransitionDelegate:NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentationController = PresentationController(presentedViewController: presented, presenting: presenting)
        
        return presentationController
        
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = AnimatedTransitioning()
        animationController.isPresentation = true
        
        return animationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = AnimatedTransitioning()
        animationController.isPresentation = false
        
        return animationController
    }
    
    
}



