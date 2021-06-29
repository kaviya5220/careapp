//
//  ProfileViewController.swift
//  appUIKit
//
//  Created by sysadmin on 10/06/21.
//

import UIKit

class ProfileViewController: UIViewController {
    let addbutton:UIButton = {
        let button = UIButton()
        button.setTitle("LOGOUT", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(logout(_:)), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addbutton)
       // self.navigationController?.isNavigationBarHidden = tru
        addbutton.translatesAutoresizingMaskIntoConstraints = false
        addbutton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addbutton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

        

        // Do any additional setup after loading the view.
    }
    @objc func logout(_ sender: UIButton)
    {
        let login = LoginViewController()
        let userDefaults =  UserDefaults.standard
        let nav = UINavigationController(rootViewController: login)
        
        userDefaults.removeObject(forKey: "userid")
            userDefaults.synchronize()
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(nav)
            }
        
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
