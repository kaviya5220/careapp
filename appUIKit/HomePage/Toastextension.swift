//
//  HomeViewController.swift
//  appUIKit
//
//  Created by sysadmin on 09/06/21.
//

import UIKit

class HomeViewController: UIViewController {
    let addbutton:UIButton = {
        let button = UIButton()
        button.setTitle("SUBMIT", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(insertUser(_:)), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(addbutton)
        
        addbutton.translatesAutoresizingMaskIntoConstraints = false
       
        addbutton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addbutton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

    }
    @objc func insertUser(_ sender: UIButton) {
        self.showToast(message: "Your Toast Message", font: .systemFont(ofSize: 12.0))
        
        }

}
extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }
