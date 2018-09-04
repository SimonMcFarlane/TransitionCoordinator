//
//  TransitionAnimatorRadial.swift
//  Pods-TransitionCoordinator_Example
//
//  Created by Simon McFarlane on 03/09/2018.
//

import UIKit

open class TransitionAnimatorRadial: TransitionAnimator
{
    // MARK: - Properties
    
    fileprivate var transitionContext: UIViewControllerContextTransitioning?
    fileprivate var sourcePoint: CGPoint = CGPoint.zero
    
    
    // MARK: - Initialization
    
    public init(sourcePoint: CGPoint, navigationBackImage: UIImage? = nil, navigationBackTitle: String? = nil)
    {
        super.init(navigationBackImage: navigationBackImage, navigationBackTitle: navigationBackTitle)
        
        self.sourcePoint = sourcePoint
    }
    
    
    // MARK: - UIViewControllerContextTransitioning
    
    override open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 0.5
    }
    
    override open func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        let containerView = transitionContext.containerView
        
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        if self.presenting == true
        {
            if let fromView = fromView
            {
                containerView.addSubview(fromView)
            }
            
            if let toView = toView
            {
                containerView.addSubview(toView)
                
                if let toViewController = toViewController
                {
                    toView.frame = transitionContext.finalFrame(for: toViewController)
                }
                
                let radialPathStartRect = CGRect(x: self.sourcePoint.x - 10.0, y: self.sourcePoint.y - 10.0, width: 20.0, height: 20.0)
                
                let radialPathStart = UIBezierPath(ovalIn: radialPathStartRect)
                let radialPathEnd = UIBezierPath(ovalIn: radialPathStartRect.insetBy(dx: -containerView.frame.size.height, dy: -containerView.frame.size.height))
                
                let maskLayer = CAShapeLayer()
                maskLayer.path = radialPathEnd.cgPath
                toView.layer.mask = maskLayer
                
                let maskLayerAnimation = CABasicAnimation(keyPath: "path")
                maskLayerAnimation.fromValue = radialPathStart.cgPath
                maskLayerAnimation.toValue = radialPathEnd.cgPath
                maskLayerAnimation.duration = self.transitionDuration(using: transitionContext)
                maskLayerAnimation.delegate = self
                maskLayer.add(maskLayerAnimation, forKey: "path")
                
                self.transitionContext = transitionContext
            }
            else
            {
                transitionContext.completeTransition(true)
            }
        }
        else
        {
            if let toView = toView
            {
                containerView.addSubview(toView)
            }
            
            if let fromView = fromView
            {
                containerView.addSubview(fromView)
                
                let radialPathStartRect = CGRect(x: self.sourcePoint.x - 10.0, y: self.sourcePoint.y - 10.0, width: 20.0, height: 20.0)
                
                let radialPathStart = UIBezierPath(ovalIn: radialPathStartRect)
                let radialPathEnd = UIBezierPath(ovalIn: radialPathStartRect.insetBy(dx: -containerView.frame.size.height, dy: -containerView.frame.size.height))
                
                let maskLayer = CAShapeLayer()
                maskLayer.path = radialPathEnd.cgPath
                fromView.layer.mask = maskLayer
                
                let maskLayerAnimation = CABasicAnimation(keyPath: "path")
                maskLayerAnimation.fromValue = radialPathEnd.cgPath
                maskLayerAnimation.toValue = radialPathStart.cgPath
                maskLayerAnimation.duration = self.transitionDuration(using: transitionContext)
                maskLayerAnimation.delegate = self
                maskLayerAnimation.fillMode = kCAFillModeForwards
                maskLayerAnimation.isRemovedOnCompletion = false
                maskLayer.add(maskLayerAnimation, forKey: "path")
                
                self.transitionContext = transitionContext
            }
            else
            {
                transitionContext.completeTransition(true)
            }
        }
    }
}


// MARK: - CAAnimationDelegate

extension TransitionAnimatorRadial: CAAnimationDelegate
{
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool)
    {
        self.transitionContext?.completeTransition(true)
        
        self.transitionContext?.view(forKey: UITransitionContextViewKey.to)?.layer.mask = nil
        self.transitionContext?.view(forKey: UITransitionContextViewKey.from)?.layer.mask = nil
        
        self.transitionContext = nil
    }
}

