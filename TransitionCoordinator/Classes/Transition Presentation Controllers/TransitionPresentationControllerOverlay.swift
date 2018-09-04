//
//  TransitionPresentationControllerOverlay.swift
//  Pods-TransitionCoordinator_Example
//
//  Created by Simon McFarlane on 03/09/2018.
//

import UIKit

open class TransitionPresentationControllerOverlay: TransitionPresentationController
{
    // MARK: - Properties
    
    fileprivate var decorationView: UIView = UIView()
    
    /// Indicate whether the view controller's view we are transitioning from will be removed from the window in the end of the presentation transition.
    override open var shouldRemovePresentersView : Bool
    {
        return false
    }
    
    
    //MARK: - Life Cycle

    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        coordinator.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext) in
            self.presentedView?.frame = self.frameOfPresentedViewInContainerView
            
        }, completion: nil)
    }
    
    override open func presentationTransitionWillBegin()
    {
        self.decorationView.removeFromSuperview()
        
        if let containerView = self.containerView
        {
            self.decorationView.frame = containerView.bounds
            self.decorationView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.decorationView.alpha = 0.0
            containerView.addSubview(decorationView)
            
            if let presentedView = self.presentedView
            {
                containerView.addSubview(presentedView)
            }
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.decorationView.alpha = 1.0
        })
    }
    
    override open func presentationTransitionDidEnd(_ completed: Bool)
    {
        if completed == false
        {
            self.decorationView.removeFromSuperview()
        }
    }
    
    override open func dismissalTransitionWillBegin()
    {
        UIView.animate(withDuration: 0.3, animations: {
            self.decorationView.alpha = 0.0
        })
    }
    
    override open func dismissalTransitionDidEnd(_ completed: Bool)
    {
        if completed == true
        {
            self.decorationView.removeFromSuperview()
        }
    }
    
    /// Position of the presented view in the container view by the end of the presentation transition.
    override open var frameOfPresentedViewInContainerView : CGRect
    {
        return self.containerView!.bounds.insetBy(dx: 32.0, dy: 32.0)
    }
}
