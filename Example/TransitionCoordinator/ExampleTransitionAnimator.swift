//
//  ExampleTransitionAnimator.swift
//  TransitionCoordinator_Example
//
//  Created by Simon McFarlane on 03/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import TransitionCoordinator

class ExampleTransitionAnimator: TransitionAnimator
{
    // MARK: - UIViewControllerContextTransitioning
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 0.6
    }
    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
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
            startFrameForToView.origin.x = -startFrameForToView.size.width * 2.0
            
            toView.frame = startFrameForToView
            
            toView.transform = CGAffineTransform(rotationAngle: 0.785398).concatenating(CGAffineTransform(scaleX: 0.25, y: 0.25))
            
            
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .beginFromCurrentState, animations: {
                
                toView.transform = CGAffineTransform.identity
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
                
                fromView.frame = CGRect(x: -fromView.frame.size.width * 2.0, y: fromView.frame.origin.y, width: fromView.frame.size.width, height: fromView.frame.size.height)
                fromView.transform = CGAffineTransform(rotationAngle: 0.785398).concatenating(CGAffineTransform(scaleX: 0.25, y: 0.25))
                
            }, completion: { (_) in
                
                transitionContext.completeTransition(true)
                
            })
        }
    }
}
