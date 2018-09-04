//
//  TransitionCoordinator.swift
//  Pods-TransitionCoordinator_Example
//
//  Created by Simon McFarlane on 03/09/2018.
//

import UIKit

public protocol TransitionCoordinatorPushableViewController
{
    var pushTransitionAnimator: TransitionAnimator? { get set }
}

public protocol TransitionCoordinatorPresentableViewController
{
    var presentTransitionAnimator: TransitionAnimator? { get set }
    var presentTransitionPresentationController: TransitionPresentationController? { get set }
}

open class TransitionCoordinator: NSObject, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate
{
    // MARK: - Properties
    
    open static let sharedCoordinator = TransitionCoordinator()
    
    
    // MARK: - Transition Animator
    
    open func setPushTransitionAnimator(_ transitionAnimator: TransitionAnimator, forViewController viewController: UIViewController, withNavigationController navigationController: UINavigationController)
    {
        guard var transitionViewController = viewController as? TransitionCoordinatorPushableViewController else
        {
            print("Transition Coordinator attempting to animate a View Controller that doesn't conform to the TransitionCoordinatorPushableViewController protocol: \(viewController)")
            return
        }
        
        transitionViewController.pushTransitionAnimator = transitionAnimator
        navigationController.delegate = self
    }
    
    open func setPresentTransitionAnimator(_ transitionAnimator: TransitionAnimator, transitionPresentationController: TransitionPresentationController? = nil, forViewController viewController: UIViewController)
    {
        var topViewController = viewController
        
        if let navigationController = viewController as? UINavigationController
        {
            topViewController = navigationController.topViewController ?? topViewController
        }
        
        guard var transitionViewController = topViewController as? TransitionCoordinatorPresentableViewController else
        {
            print("Transition Coordinator attempting to animate a View Controller that doesn't conform to the TransitionCoordinatorPresentableViewController protocol: \(viewController)")
            return
        }
        
        transitionViewController.presentTransitionAnimator = transitionAnimator
        transitionViewController.presentTransitionPresentationController = transitionPresentationController
        
        if let _ = transitionPresentationController
        {
            viewController.modalPresentationStyle = .custom
        }
        else
        {
            viewController.modalPresentationStyle = .fullScreen
        }
        
        viewController.transitioningDelegate = self
    }
    
    
    // MARK: - UINavigationControllerDelegate
    
    open func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let sourceViewController = (operation == .pop) ? toVC : fromVC
        let destinationViewController = (operation == .pop) ? fromVC : toVC
        
        guard let transitionViewController = destinationViewController as? TransitionCoordinatorPushableViewController else { return nil }
        guard let transitionAnimator = transitionViewController.pushTransitionAnimator else { return nil }
        
        switch operation
        {
        case .pop:
            transitionAnimator.presenting = false
            self.setBackImageForNavigationController(navigationController, withTransitionAnimator: (sourceViewController as? TransitionCoordinatorPushableViewController)?.pushTransitionAnimator)
            
        default:
            transitionAnimator.presenting = true
            self.setBackImageForNavigationController(navigationController, withTransitionAnimator: transitionAnimator)
            self.setBackTitleForViewController(sourceViewController, withTransitionAnimator: transitionAnimator)
        }
        
        if transitionAnimator is TransitionAnimatorDefault
        {
            return nil
        }
        else
        {
            return transitionAnimator
        }
    }
    
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    open func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
    {
        let topViewController = self.topViewControllerForViewControllerOrNavigationController(presented)
        
        guard let transitionViewController = topViewController as? TransitionCoordinatorPresentableViewController else { return nil }
        
        return transitionViewController.presentTransitionPresentationController
    }
    
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        let topViewController = self.topViewControllerForViewControllerOrNavigationController(presented)
        
        guard let transitionViewController = topViewController as? TransitionCoordinatorPresentableViewController else { return nil }
        
        transitionViewController.presentTransitionAnimator?.presenting = true
        
        if transitionViewController.presentTransitionAnimator is TransitionAnimatorDefault
        {
            return nil
        }
        else
        {
            return transitionViewController.presentTransitionAnimator
        }
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        let topViewController = self.topViewControllerForViewControllerOrNavigationController(dismissed)
        
        guard let transitionViewController = topViewController as? TransitionCoordinatorPresentableViewController else { return nil }
        
        transitionViewController.presentTransitionAnimator?.presenting = false
        
        if transitionViewController.presentTransitionAnimator is TransitionAnimatorDefault
        {
            return nil
        }
        else
        {
            return transitionViewController.presentTransitionAnimator
        }
    }
    
    
    // MARK: - Convenience
    
    fileprivate func topViewControllerForViewControllerOrNavigationController(_ viewControllerOrNavigationController: UIViewController) -> UIViewController
    {
        if let navigationController = viewControllerOrNavigationController as? UINavigationController, let topViewController = navigationController.topViewController
        {
            return topViewController
        }
        
        return viewControllerOrNavigationController
    }
    
    fileprivate func setBackImageForNavigationController(_ navigationController: UINavigationController, withTransitionAnimator transitionAnimator: TransitionAnimator?)
    {
        navigationController.navigationBar.backIndicatorImage = transitionAnimator?.navigationBackImage
        navigationController.navigationBar.backIndicatorTransitionMaskImage = transitionAnimator?.navigationBackImage
    }
    
    fileprivate func setBackTitleForViewController(_ viewController: UIViewController, withTransitionAnimator transitionAnimator: TransitionAnimator?)
    {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: transitionAnimator?.navigationBackTitle, style: .plain, target: nil, action: nil)
    }
}
