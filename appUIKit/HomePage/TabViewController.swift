//
//  HomeViewController.swift
//  appUIKit
//
//  Created by sysadmin on 09/06/21.
//

import UIKit

class TabViewController: UITabBarController,UITabBarControllerDelegate, UINavigationControllerDelegate {
    
    
    var tabOne = ReceiverViewController()
//    @objc func didTapAdd(_ sender: UIButton) {
//        let addItem = AddItemViewController()
//        let vc = UINavigationController(rootViewController:addItem)
//        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//        addItem.delegate = self
//        self.present(vc, animated: true, completion: nil)
//        print("Hello")
//        }
//        
    override func viewDidLoad() {
            super.viewDidLoad()
//            let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd(_:)))
//            self.navigationItem.rightBarButtonItem = add
            let tabOneBarItem = UITabBarItem(title: "HOME", image: UIImage(systemName: "house"), selectedImage: UIImage(named: "house"))
            tabOne.tabBarItem = tabOneBarItem
            let tabTwo = ProfileViewController()
            let tabTwoBarItem = UITabBarItem(title: "PROFILE", image: UIImage(systemName: "person"), selectedImage: UIImage(named: "person"))
            tabTwo.tabBarItem = tabTwoBarItem
            
            
            self.viewControllers = [tabOne, tabTwo]
        }
        
        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        }
    }

