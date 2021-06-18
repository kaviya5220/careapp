//
//  HomeViewController.swift
//  appUIKit
//
//  Created by sysadmin on 09/06/21.
//

import UIKit

class TabViewController: UITabBarController,UITabBarControllerDelegate, canReceive {
    func passData() {
        tabOne.reload()
    }
    var tabOne = ReceiverViewController()
        override func viewDidLoad() {
            super.viewDidLoad()
            self.delegate = self
            print("Discarded")
            
        }
    init(){
        print("view did load")
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapAdd(_ sender: UIButton) {
      //  let vc = AddItemViewController()
       // let rootViewController = UITabBarController()
        let vc = UINavigationController(rootViewController: AddItemViewController())
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        //vc.isModalInPresentation = true
       // vc.delegate = self
        //self.present(vc, animated: true, completion: nil)
        self.present(vc, animated: true)
        print("Hello")
        
      //  self.navigationController?.pushViewController(vc, animated: true)
        
        
        
        }
        
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        
            
            
            print("View will appear ca")
            
            //let plusbutton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd(_:)))
            //self.navigationItem.rightBarButtonItem = plusbutton
            let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd(_:)))
            //let filter = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle"),style: .plain,target: self ,action:  nil)
           // let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: nil)

            self.navigationItem.rightBarButtonItem = add
           // self.navigationItem.leftBarButtonItem = filter
            
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
