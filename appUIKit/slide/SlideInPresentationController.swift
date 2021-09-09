//
//  SlideInPresentationController.swift
//  learnUI
//
//  Created by Kaviya M on 07/09/21.
//

import UIKit

class SlideInPresentationController: UIPresentationController {
 
    private var direction: PresentationDirection
    private var dimmingView: UIView!
    var origin : Int

    init(presentedViewController: UIViewController,
         presenting presentingViewController: UIViewController?,
         direction: PresentationDirection,origin : Int) {
      self.direction = direction
        self.origin = origin

      super.init(presentedViewController: presentedViewController,
                 presenting: presentingViewController)
        let recognizer = UITapGestureRecognizer(
          target: self,
          action: #selector(handleTap(recognizer:)))
        setupDimmingView()
        dimmingView.addGestureRecognizer(recognizer)
        

    }
    
    override func presentationTransitionWillBegin() {
      guard let dimmingView = dimmingView else {
        return
      }
      containerView?.insertSubview(dimmingView, at: 0)

      
      NSLayoutConstraint.activate(
        NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|",
          options: [], metrics: nil, views: ["dimmingView": dimmingView]))
      NSLayoutConstraint.activate(
        NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|",
          options: [], metrics: nil, views: ["dimmingView": dimmingView]))

      
      guard let coordinator = presentedViewController.transitionCoordinator else {
        dimmingView.alpha = 1.0
        return
      }

      coordinator.animate(alongsideTransition: { _ in
        self.dimmingView.alpha = 1.0
      })
    }
    override func dismissalTransitionWillBegin() {
      guard let coordinator = presentedViewController.transitionCoordinator else {
        dimmingView.alpha = 0.0
        return
      }

      coordinator.animate(alongsideTransition: { _ in
        self.dimmingView.alpha = 0.0
      })
    }
    override func containerViewWillLayoutSubviews() {
      presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer,
                       withParentContainerSize parentSize: CGSize) -> CGSize {
      switch direction {
      case .left, .right:
        return CGSize(width: parentSize.width*(2.3/3.0), height: parentSize.height)
      case .bottom, .top:
        return CGSize(width: parentSize.width, height: parentSize.height*(2.0/3.0))
      }
    }
    override var frameOfPresentedViewInContainerView: CGRect {
     
      var frame: CGRect = .zero
      frame.size = size(forChildContentContainer: presentedViewController,
                        withParentContainerSize: containerView!.bounds.size)
      switch direction {
      
      case .right:
        frame.origin.x = containerView!.frame.width*(0.95/4.0)
        //print(origin)
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height + CGFloat(origin)
        frame.origin.y = topBarHeight
      case .bottom:
        frame.origin.y = containerView!.frame.height*(1.0/3.0)
      default:
        frame.origin = .zero
      }
      return frame
    }
}
private extension SlideInPresentationController {
  func setupDimmingView() {
    dimmingView = UIView()
    dimmingView.translatesAutoresizingMaskIntoConstraints = false
    dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
    dimmingView.alpha = 0.0
  }

    @objc func handleTap(recognizer: UITapGestureRecognizer) {
      presentingViewController.dismiss(animated: true)
    }

}


