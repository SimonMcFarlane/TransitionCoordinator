//
//  TransitionAnimatorTopToBottom.swift
//  Pods-TransitionCoordinator_Example
//
//  Created by Simon McFarlane on 03/09/2018.
//

import UIKit

open class TransitionAnimatorTopToBottom: TransitionAnimator
{
    // MARK: - UIViewControllerContextTransitioning
    
    override open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 0.3
    }
    
    override open func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        let containerView = transitionContext.containerView
        
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        if self.presenting == true
        {
            guard let toView = toView else { return }
            guard let toViewController = toViewController else { return }
            
            if let fromView = fromView
            {
                containerView.addSubview(fromView)
            }
            
            containerView.addSubview(toView)
            
            let finalFrameForToView = transitionContext.finalFrame(for: toViewController)
            
            var startFrameForToView = finalFrameForToView
            startFrameForToView.origin.y = -startFrameForToView.size.height
            
            toView.frame = startFrameForToView
            
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                
                toView.frame = finalFrameForToView
                
            }, completion: { (_) in
                
                transitionContext.completeTransition(true)
                
            })
            
        }
        else
        {
            guard let fromView = fromView else { return }
            
            if let toView = toView
            {
                containerView.addSubview(toView)
            }
            
            containerView.addSubview(fromView)
            
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                
                fromView.frame = CGRect(x: fromView.frame.origin.x, y: -fromView.frame.size.height, width: fromView.frame.size.width, height: fromView.frame.size.height)
                
            }, completion: { (_) in
                
                transitionContext.completeTransition(true)
                
            })
        }
    }
}
