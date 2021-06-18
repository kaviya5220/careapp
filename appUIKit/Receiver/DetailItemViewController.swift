//
//  DetailItemViewController.swift
//  appUIKit
//
//  Created by sysadmin on 16/06/21.
//

import UIKit

class DetailItemViewController: UIViewController {
    var itemid : Int = 0
    let verticalstackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.distribution = .fillProportionally
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let horizontalstackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let horizontalstackView1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let loginbutton:CustomButton = {
        let button = CustomButton(title: "LOGIN", bgColor: .systemBlue)
      //  button.addTarget(self, action: #selector(insertUser(_:)), for: .touchUpInside)
        return button
    }()
    let loginbutton1:CustomButton = {
        let button = CustomButton(title: "LOGIN", bgColor: .systemBlue)
      //  button.addTarget(self, action: #selector(insertUser(_:)), for: .touchUpInside)
        return button
    }()
    let loginbutton2:CustomButton = {
        let button = CustomButton(title: "LOGIN", bgColor: .systemBlue)
      //  button.addTarget(self, action: #selector(insertUser(_:)), for: .touchUpInside)
        return button
    }()
    let loginbutton3:CustomButton = {
        let button = CustomButton(title: "LOGIN", bgColor: .systemBlue)
      //  button.addTarget(self, action: #selector(insertUser(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        horizontalstackView.addArrangedSubview(loginbutton)
        horizontalstackView.addArrangedSubview(loginbutton1)
        
        horizontalstackView1.addArrangedSubview(loginbutton2)
        horizontalstackView1.addArrangedSubview(loginbutton3)
        verticalstackView.addArrangedSubview(horizontalstackView)
        verticalstackView.addArrangedSubview(horizontalstackView1)
        view.addSubview(verticalstackView)
        print(itemid)
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints: sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)
    }
    
    private var sharedConstraints = [NSLayoutConstraint]()
    private var compactConstraints = [NSLayoutConstraint]()
    private var regularConstraints = [NSLayoutConstraint]()

}
extension DetailItemViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints:sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)
    }
    
    private func setupConstraints() {
        
        sharedConstraints.append(contentsOf: [
            verticalstackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        compactConstraints.append(contentsOf: [
           // loginbutton.widthAnchor.constraint(equalTo: self.horizontalstackView.widthAnchor,multiplier: 0.5),
            //loginbutton1.widthAnchor.constraint(equalTo: self.horizontalstackView.widthAnchor,multiplier: 0.5),
           // loginbutton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            verticalstackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            verticalstackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
          //  verticalstackView.topAnchor.constraint(equalTo: view.topAnchor),
            //verticalstackView.bottomAnchor.constraint(equalTo: horizontalstackView1.bottomAnchor),
            //verticalstackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
           // horizontalstackView.topAnchor.constraint(equalTo: verticalstackView.topAnchor),
            horizontalstackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            horizontalstackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
           // horizontalstackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
          //  horizontalstackView1.topAnchor.constraint(equalTo:horizontalstackView.bottomAnchor),
            horizontalstackView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            horizontalstackView1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
        
        regularConstraints.append(contentsOf: [
         //   loginlabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            verticalstackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            verticalstackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            horizontalstackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            horizontalstackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
}
