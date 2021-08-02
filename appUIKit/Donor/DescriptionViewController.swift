//
//  DescriptionViewController.swift
//  appUIKit
//
//  Created by sysadmin on 30/07/21.
//

import UIKit

class DescriptionViewController: UIViewController {
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let desc:CustomLabel = {
        let label = CustomLabel(labelType: .title)
        label.text = "Description"
        label.textAlignment = .center
        return label
    }()
    let author:UITextField = {
        let field = CustomTextField()
        field.placeholder = "Enter name"
        return field
    }()
    let publisher:UITextField = {
        let field = CustomTextField()
        field.placeholder = "Enter name"
        return field
    }()
    let yearofpublisher:UITextField = {
        let field = CustomTextField()
        field.placeholder = "Enter name"
        return field
    }()
    let Quantity:UITextField = {
        let field = CustomTextField()
        field.placeholder = "Enter name"
        return field
    }()
    let itemDescription:UITextView = {
        let description = UITextView()
        description.contentInsetAdjustmentBehavior = .automatic
        description.textAlignment = NSTextAlignment.justified
        description.isScrollEnabled = false
        description.font = UIFont.systemFont(ofSize: 18)
        description.layer.borderWidth = 1.5
        description.layer.cornerRadius = 2
        description.layer.borderColor = UIColor.systemGray.cgColor
        description.backgroundColor = UIColor.white
        description.text = "Enter Item Description"
        description.textColor = UIColor.lightGray
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.addArrangedSubview(desc)
        stackView.addArrangedSubview(author)
        stackView.addArrangedSubview(publisher)
        stackView.addArrangedSubview(yearofpublisher)
        stackView.addArrangedSubview(Quantity)
        stackView.addArrangedSubview(itemDescription)
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints: sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)

        // Do any additional setup after loading the view.
    }
    private var sharedConstraints = [NSLayoutConstraint]()
    private var compactConstraints = [NSLayoutConstraint]()
    private var regularConstraints = [NSLayoutConstraint]()
}
extension DescriptionViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints:sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)
    }
    private func setupConstraints() {

        sharedConstraints.append(contentsOf: [
        ])
        compactConstraints.append(contentsOf: [
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo : view.centerYAnchor),
//            stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.75),
//            stackView.topAnchor.constraint(equalTo: self.view.bottomAnchor,constant: 50),
        ])

        regularConstraints.append(contentsOf: [
          
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
        ])
    }
}
