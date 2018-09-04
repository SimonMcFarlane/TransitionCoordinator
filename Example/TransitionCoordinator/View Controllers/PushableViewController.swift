//
//  PushableViewController.swift
//  TransitionCoordinator_Example
//
//  Created by Simon McFarlane on 03/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import TransitionCoordinator
import UIKit

class PushableViewController: UIViewController, TransitionCoordinatorPushableViewController
{
    // MARK: - Properties
    
    var pushTransitionAnimator: TransitionAnimator?
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
}
