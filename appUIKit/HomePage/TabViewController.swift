//
//  HomeViewController.swift
//  appUIKit
//
//  Created by sysadmin on 09/06/21.
//

import UIKit

class TabViewController: UITabBarController,UITabBarControllerDelegate {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.delegate = self
            
        }
    @objc func didTapAdd(_ sender: UIButton) {
        let vc = AddItemViewController()
        vc.modalPresentationStyle = .automatic //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
        
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            let plusbutton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd(_:)))
            self.navigationItem.rightBarButtonItem = plusbutton
    
            let tabOne = ReceiverViewController()
            let tabOneBarItem = UITabBarItem(title: "HOME", image: UIImage(systemName: "house"), selectedImage: UIImage(named: "house"))
            tabOne.tabBarItem = tabOneBarItem
            
            
            let tabTwo = ProfileViewController()
            let tabTwoBarItem = UITabBarItem(title: "PROFILE", image: UIImage(systemName: "person"), selectedImage: UIImage(named: "person"))
            tabTwo.tabBarItem = tabTwoBarItem
            
            
            self.viewControllers = [tabOne, tabTwo]
        }
        
        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
           // print("Selected \(viewController.title!)")
        }
    }
