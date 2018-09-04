//
//  MenuViewController.swift
//  TransitionCoordinator
//
//  Created by Simon McFarlane on 09/03/2018.
//  Copyright (c) 2018 Simon McFarlane. All rights reserved.
//

import TransitionCoordinator
import UIKit

enum MenuViewControllerSegueIdentifier: String
{
    case PushWithDefaultTransition
    case PushWithRadialTransition
    case PushWithTopToBottomTransition
    case PushWithExampleTransition
    
    case PresentWithDefaultTransition
    case PresentWithRadialTransition
    case PresentWithTopToBottomTransition
    case PresentWithExampleTransition
}

class MenuViewController: UIViewController
{
    // MARK: - IB Actions
    
    @IBAction func programmaticallyPush(_ sender: Any)
    {
        guard let navigationController = self.navigationController else { return }
        
        let viewController = PushableViewController()
        viewController.view.backgroundColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
        viewController.title = "Programmatically Pushed"
        
        TransitionCoordinator.sharedCoordinator.setPushTransitionAnimator(TransitionAnimatorRadial(sourcePoint: viewController.view.center),
                                                                          forViewController: viewController,
                                                                          withNavigationController: navigationController)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    @IBAction func programmaticallyPresent(_ sender: Any)
    {
        let viewController = PresentableViewController()
        viewController.view.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        viewController.title = "Programmatically Presented"
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.topViewController?.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                                                   target: self,
                                                                                                   action: #selector(dismissAction(_:)))
        
        TransitionCoordinator.sharedCoordinator.setPresentTransitionAnimator(TransitionAnimatorRadial(sourcePoint: viewController.view.center),
                                                                             forViewController: navigationController)
        
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let destinationNavigationController = segue.destination as? UINavigationController
        {
            destinationNavigationController.topViewController?.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                                                                  target: self,
                                                                                                                  action: #selector(dismissAction(_:)))
        }

        guard let navigationController = self.navigationController else { return }
        
        guard
            let segueIdentifier = segue.identifier,
            let identifier = MenuViewControllerSegueIdentifier(rawValue: segueIdentifier)
            else {
                print("Unknown segue identifier")
                return
        }
        
        switch identifier
        {
        case .PushWithDefaultTransition:
            TransitionCoordinator.sharedCoordinator.setPushTransitionAnimator(TransitionAnimatorDefault(), forViewController: segue.destination, withNavigationController: navigationController)
            
        case .PushWithRadialTransition:
            TransitionCoordinator.sharedCoordinator.setPushTransitionAnimator(TransitionAnimatorRadial(sourcePoint: self.view.center), forViewController: segue.destination, withNavigationController: navigationController)
            
        case .PushWithTopToBottomTransition:
            TransitionCoordinator.sharedCoordinator.setPushTransitionAnimator(TransitionAnimatorTopToBottom(), forViewController: segue.destination, withNavigationController: navigationController)
            
        case .PushWithExampleTransition:
            TransitionCoordinator.sharedCoordinator.setPushTransitionAnimator(ExampleTransitionAnimator(), forViewController: segue.destination, withNavigationController: navigationController)

        case .PresentWithDefaultTransition:
            TransitionCoordinator.sharedCoordinator.setPresentTransitionAnimator(TransitionAnimatorDefault(), forViewController: segue.destination)
            
        case .PresentWithRadialTransition:
            TransitionCoordinator.sharedCoordinator.setPresentTransitionAnimator(TransitionAnimatorRadial(sourcePoint: self.view.center), forViewController: segue.destination)
            
        case .PresentWithTopToBottomTransition:
            TransitionCoordinator.sharedCoordinator.setPresentTransitionAnimator(TransitionAnimatorTopToBottom(), forViewController: segue.destination)
            
        case .PresentWithExampleTransition:
            TransitionCoordinator.sharedCoordinator.setPresentTransitionAnimator(ExampleTransitionAnimator(), forViewController: segue.destination)
        }
    }
    
    
    // MARK: - Helpers
    
    @objc func dismissAction(_ sender: UIBarButtonItem)
    {
        self.dismiss(animated: true, completion: nil)
    }
}
