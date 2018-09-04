//
//  PresentableViewController.swift
//  TransitionCoordinator_Example
//
//  Created by Simon McFarlane on 03/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import TransitionCoordinator
import UIKit

class PresentableViewController: UIViewController, TransitionCoordinatorPresentableViewController
{
    // MARK: - Properties
    
    var presentTransitionAnimator: TransitionAnimator?
    var presentTransitionPresentationController: TransitionPresentationController?
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
}
