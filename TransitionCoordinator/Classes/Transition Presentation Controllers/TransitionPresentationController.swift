//
//  TransitionPresentationController.swift
//  Pods-TransitionCoordinator_Example
//
//  Created by Simon McFarlane on 03/09/2018.
//

import UIKit

open class TransitionPresentationController: UIPresentationController
{
    // MARK: - Properties
    
    override open var shouldRemovePresentersView: Bool
    {
        return true
    }
    
    
    // MARK: - Initialization
    
    override public init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?)
    {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    public init(segue: UIStoryboardSegue)
    {
        super.init(presentedViewController: segue.destination, presenting: segue.source)
    }
}
