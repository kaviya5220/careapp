//
//  AddItemControllerViewController.swift
//  appUIKit
//
//  Created by sysadmin on 09/06/21.
//

import UIKit

class AddItemViewController: UIViewController {
    var db = DBHelper()

    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let itemlabel:UILabel = {
        let label = UILabel()
        label.text = "ITEM DETAILS "
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let itemname:UITextField = {
        let namefield = CustomTextField()
        namefield.placeholder = "Enter Item Name"
        return namefield
    }()
    let itemDescription:UITextField = {
        let description = CustomTextField()
        description.placeholder = "Enter Item Descrption"
        return description
    }()
    let itemQuantity:UITextField = {
        let quantity = CustomTextField()
        quantity.placeholder = "Enter Item Quantity"
        return quantity
    }()
    let address:UITextField = {
        let address = CustomTextField()
        address.placeholder = "Enter Address"
        return address
    }()
    let addbutton:UIButton = {
        let button = UIButton()
        button.setTitle("UPLOAD ITEM", for: .normal)
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
        self.title = "Add Item"
        view.backgroundColor = .white
        view.addSubview(stackView)
        view.addSubview(itemlabel)
        stackView.addArrangedSubview(itemname)
        stackView.setCustomSpacing(25, after: itemname)
        stackView.addArrangedSubview(itemDescription)
        stackView.setCustomSpacing(25, after: itemDescription)
        stackView.addArrangedSubview(itemQuantity)
        stackView.setCustomSpacing(25, after: itemQuantity)
        stackView.addArrangedSubview(address)
        stackView.setCustomSpacing(25, after: address)
        view.addSubview(addbutton)
        
        itemlabel.translatesAutoresizingMaskIntoConstraints = false
        itemlabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 30).isActive = true
        itemlabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.itemlabel.bottomAnchor,constant: 25).isActive = true
        stackView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant:20).isActive = true
        stackView.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant:-10).isActive = true
        
        addbutton.translatesAutoresizingMaskIntoConstraints = false
        addbutton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor,constant: 25).isActive = true
        addbutton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    @objc func insertUser(_ sender: UIButton) {
        let userdefaults = UserDefaults.standard
        let userid = userdefaults.integer(forKey: "userid")
        print(userid)
        let item: Item = Item(item_id: 0, item_name: itemname.text!, item_description: itemDescription.text!, item_quantity: itemQuantity.text!, address: address.text!, Donar_ID: userid)
        db.insertItem(itemarg: item)
        self.showToast(message: "Uploaded Successfully", font: .systemFont(ofSize: 12.0))
        
            self.navigationController?.pushViewController(TabViewController(), animated: true)
        
        }

}

