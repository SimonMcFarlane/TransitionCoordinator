//
//  TransitionAnimator.swift
//  Pods-TransitionCoordinator_Example
//
//  Created by Simon McFarlane on 03/09/2018.
//

import UIKit

open class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning
{
    // MARK: - Properties
    
    open var presenting: Bool = false
    
    internal var navigationBackImage: UIImage?
    internal var navigationBackTitle: String?
    
    
    // MARK: - Initialization
    
    override public init()
    {
        super.init()
    }
    
    public init(navigationBackImage: UIImage?, navigationBackTitle: String?)
    {
        super.init()
        
        self.navigationBackImage = navigationBackImage
        self.navigationBackTitle = navigationBackTitle
    }
    
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 0.0
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
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
            toView.frame = finalFrameForToView
            
            transitionContext.completeTransition(true)
            
        }
        else
        {
            guard let fromView = fromView else { return }
            
            if let toView = toView
            {
                containerView.addSubview(toView)
            }
            
            containerView.addSubview(fromView)
            
            fromView.frame = CGRect(x: fromView.frame.origin.x, y: -fromView.frame.size.height, width: fromView.frame.size.width, height: fromView.frame.size.height)
            
            transitionContext.completeTransition(true)
        }
    }
}

