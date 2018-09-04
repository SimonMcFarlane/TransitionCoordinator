# TransitionCoordinator

[![Version](https://img.shields.io/cocoapods/v/TransitionCoordinator.svg?style=flat)](https://cocoapods.org/pods/TransitionCoordinator)
[![License](https://img.shields.io/cocoapods/l/TransitionCoordinator.svg?style=flat)](https://cocoapods.org/pods/TransitionCoordinator)
[![Platform](https://img.shields.io/cocoapods/p/TransitionCoordinator.svg?style=flat)](https://cocoapods.org/pods/TransitionCoordinator)

## Installation

TransitionCoordinator is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TransitionCoordinator'
```

## Overview
TransitionCoordinator is designed to simplfy the handling of custom view controller transitions in iOS apps.

##### What features does it have?
- handles the pushing/popping of `UIViewController` on/off a `UINavigationController`'s stack.
- handles the presenting/dismissing of `UIViewController` modally.
- allows each transition to use a different `TransitionAnimator`. This therefore allows a chain of view controllers to be pushed onto a navigation stack, all with different transitions.
- allows each transition to specify an image and/or text for it's back button.
- comes pre-loaded with some basic transitions.
- has an easy structure to add and use your own custom transitions.
- supports view controller transitions both programmatically and via `UIStoryboardSegue`.


## How does it works

The library is comprised of three parts. The `TransitionCoordinator`, `TransitionAnimator` and `TransitionPresentationController`.

#### TransitionCoordinator

The TransitionCoordinator singleton provides convenience functions, which can be used to specify animations when pushing or presenting a view controller.

Before beginning a transition, the transition coordinator will ask the view controller for it's `TransitionAnimator` (and `TransitionPresentationController` if it's being presented modally), which is used for the actual transition animation. This applies to both the transition to the next view controller and the transition to the previous view controller.

As each view controller defines it's own transition, this allows each view controller to be pushed onto a navigation stack with a unique transition. For example, it is possible to push view controllers onto a navigation stack one at a time with transitions such as *'radial'* -> *'vertical'* -> *'fade'*. When the view controllers are popped off the navigation stack, they will be popped with the animations in order of *'fade'* -> *'vertical'* -> *'radial'*.


#### TransitionAnimator

The `TransitionAnimator` dictates how the transition will be animated. You can create your own subclass to make a specific animation, or use one of the provided classes.

The `TransitionAnimator` is the component that descibes the actual animation that takes place. e.g. a vertical animation or a radial wipe. It can also be initialised with both an optional `navigationBackImage` and `navigationBackTitle`. This allows each view controller being presented to define it's own back-button and back-button title. This is a useful feature due to the fact that if you decide that you want to push your navigation controller's view controllers vertically instead of the standard horizontal way, a 'back' button may not make as much sense as displaying an 'up' button to pop back.

The `TransitionAnimator` conforms to the `UIViewControllerAnimatedTransitioning` protocol and implements the functions:

```Swift
public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval

public func animateTransition(transitionContext: UIViewControllerContextTransitioning)
```
	
This allows you to define the both the duration and the actual animation itself. To create your own animations you should subclass `TransitionAnimator` and implement these functions. See the bundled project for transition animator examples.

#### TransitionPresentationController

`TransitionPresentationController` is a `UIPresentationController` subclass and provides advanced view and transition management for presented view controllers. If you are pushing a view controller onto a navigation stack, then the `TransitionPresentationController` is **not needed**. It is used for presenting view controllers only.

The `TransitionPresentationController` should be used when presenting a view controller, and defines how that view controller will be presented. You can create your own subclass to define a specific style, or use one of the provided classes. The Transition Presentation Controller is optional, if one isn't provided a default Full Screen Modal will be shown.


## Usage

##### Pushing a view controller

When pushing a `UIViewController` onto the stack of a `UINavigationController` the view controller must conform to the `TransitionCoordinatorPushableViewController` protocol. This ensures that the view controller defines its own `TransitionAnimator` (which the coordinator will ask for when it is going to perform the transition).

###### To perform the push transition programmatically:

```Swift
guard let navigationController = self.navigationController else { return }
let viewController = PushableViewController()
	
TransitionCoordinator.sharedCoordinator.setPushTransitionAnimator(TransitionAnimatorTopToBottom(),
                                                                  forViewController: viewController,
                                                                  withNavigationController: navigationController)
	
navigationController.pushViewController(viewController, animated: true)
```

Note that the `TransitionCoordinator` **must** be invoked before the view controller is pushed.


###### To perform the push transition via UIStoryboardSegue:
	
```Swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?)
{
	guard let navigationController = self.navigationController else { return }
	    
	TransitionCoordinator.sharedCoordinator.setPushTransitionAnimator(TransitionAnimatorTopToBottom(),
	                                                                  forViewController: segue.destination,
	                                                                  withNavigationController: navigationController)
}
```

##### Presenting a view controller

When presenting a `UIViewController` modally the view controller must conform to the `TransitionCoordinatorPresentableViewController` protocol. This ensures that the view controller defines its own `TransitionAnimator` and `TransitionPresentationController` (which the coordinator will ask for when it is going to perform the transition).

###### To perform the present transition programmatically:

```Swift
let viewController = PresentableViewController()
let navigationController = UINavigationController(rootViewController: viewController)
    
TransitionCoordinator.sharedCoordinator.setPresentTransitionAnimator(TransitionAnimatorTopToBottom(),
                                                                     forViewController: navigationController)
    
self.present(navigationController, animated: true, completion: nil)
```

###### To perform the present transition via UIStoryboardSegue:

```Swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?)
{
    TransitionCoordinator.sharedCoordinator.setPresentTransitionAnimator(TransitionAnimatorTopToBottom(),
                                                                         forViewController: segue.destination)
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Requirements

- iOS 9.3+
- Swift

## Author

Simon McFarlane, [simon@plusplus.ltd](simon@plusplus.ltd)


## License

TransitionCoordinator is available under the MIT license. See the LICENSE file for more info.
