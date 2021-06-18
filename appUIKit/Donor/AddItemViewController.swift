//
//  AddItemControllerViewController.swift
//  appUIKit
//
//  Created by sysadmin on 09/06/21.
//

import UIKit
protocol canReceive{
    func passData()
}
class AddItemViewController: UIViewController,UIAdaptivePresentationControllerDelegate, UINavigationControllerDelegate {
    
    var db = DBHelper()
    var delegate:canReceive?
    
   
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let itemlabel:CustomLabel = {
        let label = CustomLabel(labelType: .title)
        label.text = "ITEM DETAILS "
        label.textAlignment = .center
        return label
    }()
    let itemname:CustomTextField = {
        let namefield = CustomTextField()
        namefield.placeholder = "Enter Item Name"
        return namefield
    }()
    let itemDescription:CustomTextField = {
        let description = CustomTextField()
        description.placeholder = "Enter Item Descrption"
        return description
    }()
    let itemQuantity:CustomTextField = {
        let quantity = CustomTextField()
        quantity.placeholder = "Enter Item Quantity"
        return quantity
    }()
    let address:CustomTextField = {
        let address = CustomTextField()
        address.placeholder = "Enter Address"
        return address
    }()
    let addbutton:CustomButton = {
        let button = CustomButton(title: "UPLOAD ITEM", bgColor: .systemBlue)
        button.addTarget(self, action: #selector(insertUser(_:)), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        return button
    }()
    let scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        
        let upload = UIBarButtonItem(title: "Upload", style: .plain, target: self, action: #selector(insertUser(_:)))
        self.navigationItem.rightBarButtonItem = upload
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel(_:)))
        self.navigationItem.leftBarButtonItem = cancel
        
        presentationController?.delegate = self
      //  self.isModalInPresentation = true
        self.title = "Add Item"
        view.backgroundColor = .white
        setupConstraints()
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(itemlabel)
        stackView.addArrangedSubview(itemname)
        stackView.addArrangedSubview(itemDescription)
        stackView.addArrangedSubview(itemQuantity)
        stackView.addArrangedSubview(address)
       // stackView.addArrangedSubview(addbutton)
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints: sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)
    }
    
    @objc func cancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @objc func insertUser(_ sender: UIButton) {
        let userdefaults = UserDefaults.standard
        let userid = userdefaults.integer(forKey: "userid")
        print(userid)
        let item: Item = Item(item_id: 0, item_name: itemname.text!, item_description: itemDescription.text!, item_quantity: itemQuantity.text!, address: address.text!, Donar_ID: userid)
        var flag = false
        flag = DBHelper.insertItem(itemarg: item)
        if(flag == true){
            self.showToast(message: "Uploaded Successfully", font: .systemFont(ofSize: 12.0))
            // navigationController?.popViewController(animated: true)
            // dismiss(animated: true, completion: nil)
            delegate?.passData()
            print("dismissing")
          //  self.navigationController?.pushViewController(ReceiverViewController(), animated: true)
            dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
               
                   
//            }
            
            
          //  self.navigationController?.pushViewController(ReceiverViewController(), animated: true)
             
        }
        
        }
    private var sharedConstraints = [NSLayoutConstraint]()
    private var compactConstraints = [NSLayoutConstraint]()
    private var regularConstraints = [NSLayoutConstraint]()
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
            print("dismiss")
            return false
        }

        func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
            present(actionSheet, animated: true)
        }

        private var actionSheet: UIAlertController {
            let actionSheet = UIAlertController(
                title: "",
                message: "Discard Changes?",
                preferredStyle: .actionSheet
            )
            actionSheet.addAction(.init(
                title: "Yes",
                style: .destructive,
                handler: { _ in self.dismiss(animated: true) }
            ))
            actionSheet.addAction(.init(
                title: "No",
                style: .default
            ))
            return actionSheet
        }

}
extension AddItemViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints:sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)
    }
    private func setupConstraints() {
        
        sharedConstraints.append(contentsOf: [
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        
        compactConstraints.append(contentsOf: [
            itemlabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
           // addbutton.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            //addbutton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        regularConstraints.append(contentsOf: [
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            itemlabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
         //   addbutton.widthAnchor.constraint(equalTo: self.view.widthAnchor),
          //  addbutton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }
}

