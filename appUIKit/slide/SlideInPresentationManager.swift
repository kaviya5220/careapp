//
//  SlideInPresentationManager.swift
//  learnUI
//
//  Created by Kaviya M on 07/09/21.
//

import UIKit
enum PresentationDirection {
  case left
  case top
  case right
  case bottom
}

class SlideInPresentationManager: NSObject {
    var direction: PresentationDirection = .right
    var origin : Int = 0
}
extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
    func presentationController(
      forPresented presented: UIViewController,
      presenting: UIViewController?,
      source: UIViewController
    ) -> UIPresentationController? {
      let presentationController = SlideInPresentationController(
        presentedViewController: presented,
        presenting: presenting,
        direction: direction,
        origin: origin
      )
      return presentationController
    }
    func animationController(
      forPresented presented: UIViewController,
      presenting: UIViewController,
      source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
      return SlideInPresentationAnimator(direction: direction, isPresentation: true)
    }

    func animationController(
      forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
      return SlideInPresentationAnimator(direction: direction, isPresentation: false)
    }


}

