//
//  PageViewController.swift
//  appUIKit
//
//  Created by sysadmin on 21/06/21.
//



    import UIKit

    class PageViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var pageController: UIPageViewController!
        var controllers = [UIViewController]()
        public var itemid : [Int] = []
        public var current : Int = 0

        override func viewDidLoad() {
            super.viewDidLoad()
            print(itemid)
            pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            pageController.dataSource = self
            pageController.delegate = self

            addChild(pageController)
            view.addSubview(pageController.view)

            let views = ["pageController": pageController.view] as [String: AnyObject]
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[pageController]|", options: [], metrics: nil, views: views))
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[pageController]|", options: [], metrics: nil, views: views))
            let count=0...itemid.count-1
            for i in count {
                let vc = DetailItemViewController()
                 vc.itemid = itemid[i]
        
                
                vc.view.backgroundColor = .white
                controllers.append(vc)
            }

            pageController.setViewControllers([controllers[current]], direction: .forward, animated: false)
        }
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
                if let index = controllers.firstIndex(of: viewController) {
                    if index > 0 {
                        return controllers[index - 1]
                    } else {
                        return nil
                    }
                }

                return nil
            }

            func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
                if let index = controllers.firstIndex(of: viewController) {
                    if index < controllers.count - 1 {
                        return controllers[index + 1]
                    } else {
                        return nil
                    }
                }

                return nil
            }

//            func randomCGFloat() -> CGFloat {
//                return CGFloat(arc4random()) / CGFloat(UInt32.max)
//            }
//
//            func randomColor() -> UIColor {
//                return UIColor(red: randomCGFloat(), green: randomCGFloat(), blue: randomCGFloat(), alpha: 1)
//            }
}
