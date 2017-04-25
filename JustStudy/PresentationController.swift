//
//  MoviePresentationController.swift
//  MovieSelectr
//
//  Created by Training on 10/10/2016.
//  Copyright © 2016 Training. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController, UIAdaptivePresentationControllerDelegate{

    var dimmingView = UIView()
    
    override var shouldPresentInFullscreen: Bool {
        return true
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        dimmingView.alpha = 0
        
    }
    
    override func presentationTransitionWillBegin() {
        //dimmingView->灰底的view
        dimmingView.frame = self.containerView!.bounds
        dimmingView.alpha = 0
        containerView?.insertSubview(dimmingView, at: 0)
        
        
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { (context:UIViewControllerTransitionCoordinatorContext) in
                self.dimmingView.alpha = 1
                }, completion: nil)
        }else{
            dimmingView.alpha = 1
        }
        
    }
    
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { (context:UIViewControllerTransitionCoordinatorContext) in
                self.dimmingView.alpha = 0
                }, completion: nil)
        }else{
            dimmingView.alpha = 0
        }
    }
    
    override func containerViewWillLayoutSubviews() {
        if let containerBounds = containerView?.bounds {
            dimmingView.frame = containerBounds
            presentedView?.frame = containerBounds
        }
    }
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .overFullScreen
    }
    
    
    
    
}
