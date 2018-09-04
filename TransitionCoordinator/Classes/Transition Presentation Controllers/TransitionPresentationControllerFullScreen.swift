//
//  TransitionPresentationControllerFullScreen.swift
//  Pods-TransitionCoordinator_Example
//
//  Created by Simon McFarlane on 03/09/2018.
//

import UIKit

open class TransitionPresentationControllerFullScreen: TransitionPresentationController
{
    // MARK: - Properties
    
    override open var shouldRemovePresentersView: Bool
    {
        return true
    }
}
